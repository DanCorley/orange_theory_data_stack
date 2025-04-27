from datetime import datetime, timezone
from typing import Generator

import dlt
from dlt.sources.rest_api import RESTAPIConfig, rest_api_resources
from dlt.extract.resource import DltResource
from requests.models import Response

from .auth import OAuth2OTF


@dlt.source
def otf_source(args, member_uuid:str = dlt.secrets["member_uuid"]) -> Generator[DltResource, None, None]:


    def invalidate_null_content(response: Response) -> Response:
        """Set the status code to 204 if the response content is an empty string"""
        if not response.content:
            response.status_code = 204
        return response


    def add_workout_id_field(record: dict) -> dict:
        """Add workout.id to the record if it doesn't exist to be used to resolve further endpoints"""
        if not record.get("workout"):
            record["workout"] = {'id': 'workout_key'}
        return record


    config: RESTAPIConfig = {
        "client": {
            "base_url": "",
            "headers": OAuth2OTF().build_access_token_request(),
        },
        "resource_defaults": {
            "primary_key": "id",
            "write_disposition": "replace" if args.full_refresh else "merge",
            "table_format": "delta",
        },
        "resources": [
            {
                "name": "me",
                "endpoint": {
                    "path": "https://api.orangetheory.io/v1/people/me",
                    "paginator": "single_page",
                },
            },
            {
                "name": "bookings",
                "processing_steps": [
                    # make sure we have a workout key to resolve further endpoints
                    {"map": add_workout_id_field}
                ],
                "endpoint": {
                    "data_selector": "items",
                    "path": "https://api.orangetheory.io/v1/bookings/me",
                    "paginator": "single_page",
                    "params": {
                        "starts_after": {
                            "type": "incremental",
                            "cursor_path": "created_at",
                            "initial_value": "2021-01-01T00:00:00Z",
                        },
                        "ends_before": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
                        "include_canceled": "false",
                    },
                },
            },
            {
                "name": "performance_summaries",
                "include_from_parent": ["id"],
                "endpoint": {
                    "path": "https://api.orangetheory.io/v1/performance-summaries/{resources.bookings.workout.id}",
                    "paginator": "single_page",
                    "response_actions": [
                        invalidate_null_content,
                        {"status_code": 204, "action": "ignore"}
                    ],
                },
            },
            {
                "name": "body_composition",
                "primary_key": "scanResultUUId",
                "endpoint": {
                    "path": f"https://api.orangetheory.co/member/members/{member_uuid}/body-composition",
                    "paginator": "single_page",
                }
            },
            {
                "name": "heart_rate",
                "primary_key": "memberUuid",
                "endpoint": {
                    "path": f"https://api.yuzu.orangetheory.com/v1/physVars/maxHr/history?memberUuid={member_uuid}",
                    "paginator": "single_page",
                    "data_selector": "$",
                },
            },
            {
                "name": "telemetry",
                "primary_key": "classHistoryUuid",
                "include_from_parent": ["id"],
                "endpoint": {
                    "path": "https://api.yuzu.orangetheory.com/v1/performance/summary",
                    "paginator": "single_page",
                    "data_selector": "$",
                    "params": {
                        "classHistoryUuid": "{resources.bookings.workout.id}",
                        "maxDataPoints": 150
                    },
                },
            },
            {
                "name": "challenges",
                "primary_key": ["ChallengeCategoryId", "ChallengeSubCategoryId"],
                "endpoint": {
                    "path": f"https://api.orangetheory.co/challenges/v3.1/member/{member_uuid}",
                    "data_selector": "$.Dto[Programs,Challenges][*]",
                },
            },
            {
                "name": "challenge_activity",
                "primary_key": ["ChallengeCategoryId", "ChallengeName"],
                "include_from_parent": ["ChallengeSubCategoryId"],
                "max_table_nesting": 1,
                "endpoint": {
                    "path": f"https://api.orangetheory.co/challenges/v3/member/{member_uuid}/benchmarks",
                    "paginator": "single_page",
                    "data_selector": "$.Dto",
                    "params": {
                        "challengeTypeId": "{resources.challenges.ChallengeCategoryId}",
                        "challengeSubTypeId": "{resources.challenges.ChallengeSubCategoryId}",
                    },
                },
            },
            {
                # benchmarks have a different schema than challenges, but same endpoint
                "name": "benchmarks",
                "primary_key": ["EquipmentId", "EquipmentName"],
                "endpoint": {
                    "path": f"https://api.orangetheory.co/challenges/v3.1/member/{member_uuid}",
                    "data_selector": "$.Dto.Benchmarks[*]",
                },
            },
            {
                "name": "benchmark_activity",
                "primary_key": ["ChallengeCategoryId", "EquipmentId"],
                "endpoint": {
                    "path": f"https://api.orangetheory.co/challenges/v3/member/{member_uuid}/benchmarks",
                    "paginator": "single_page",
                    "data_selector": "$.Dto",
                    "params": {
                        "challengeTypeId": "1",
                        "EquipmentId": "{resources.benchmarks.EquipmentId}",
                    },
                },
            },
        ],
    }

    yield from rest_api_resources(config)
