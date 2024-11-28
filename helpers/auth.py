import os
import json
import requests
from dlt.sources.helpers.rest_client.auth import AuthConfigBase


class OAuth2OTF(AuthConfigBase):

    def __init__(self, file_name:str = '.secrets/aws_refresh_payload.json'):
        self.file_name = file_name

    def build_access_token_request(self) -> dict:
        '''helper to set the aws auth'''

        file_path = os.path.join(self.file_name)
        
        with open(file_path, 'r') as f:
            payload = json.load(f)

        # validate top keys exist in payload
        for key in ['AuthParameters', 'AuthFlow', 'ClientId']:
            assert key in payload, f'key {key} not found in payload.'

        response = requests.post(
            url="https://cognito-idp.us-east-1.amazonaws.com",
            headers={
                'Content-Type': 'application/x-amz-json-1.1',
                'X-Amz-Target': 'AWSCognitoIdentityProviderService.InitiateAuth'
            },
            json=payload
        )
        response.raise_for_status()
        return {'Authorization': response.json()['AuthenticationResult']['IdToken']}
