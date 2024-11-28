from datetime import datetime
from typing import Generator, Any

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
                        "ends_before": datetime.now().strftime("%Y-%m-%dT%H:%M:%SZ"),
                        "include_canceled": "false",
                    },
                },
            },
            {
                "name": "performance_summaries",
                "include_from_parent": ["id"],
                "endpoint": {
                    "path": "https://api.orangetheory.io/v1/performance-summaries/{id}",
                    "paginator": "single_page",
                    "params": {
                        "id": {
                            "type": "resolve",
                            "resource": "bookings",
                            "field": "workout.id",
                        },
                    },
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
                    "path": "https://api.yuzu.orangetheory.com/v1/performance/summary?classHistoryUuid={id}",
                    "paginator": "single_page",
                    "data_selector": "$",
                    "params": {
                        "id": {
                            "type": "resolve",
                            "resource": "bookings",
                            "field": "workout.id",
                        },
                        "maxDataPoints": 720
                    },
                },
            },
            # {
            #     "name": "challenges",
            #     "endpoint": {
            #         "path": f"https://api.orangetheory.co/challenges/v3.1/member/{member_uuid}",
            #         "paginator": "single_page",
            #         "data_selector": "Dto",
            #         # "response_actions": [add_and_remove_fields],
            #         # "primary_key": "name",
            #     },
            # }
        ],
    }

    yield from rest_api_resources(config)