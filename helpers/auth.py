import os
import requests
from dotenv import load_dotenv
from dlt.sources.helpers.rest_client.auth import AuthConfigBase


class OAuth2OTF(AuthConfigBase):

    def __init__(self):
        """Initialize the authentication class"""
        load_dotenv(".env")
        self.username = os.getenv("ORANGE_THEORY_EMAIL")
        self.password = os.getenv("ORANGE_THEORY_PASSWORD")

        if not self.username or not self.password:
            raise ValueError(
                "ORANGE_THEORY_EMAIL and ORANGE_THEORY_PASSWORD must be set in .env file"
            )


    def return_id_token(self) -> dict:
        """Authenticate with username/password and return the full auth response"""

        headers = {
            "Host": "cognito-idp.us-east-1.amazonaws.com",
            "X-Amz-Target": "AWSCognitoIdentityProviderService.InitiateAuth",
            "Cache-Control": "no-cache",
            "Connection": "keep-alive",
            "Accept": "*/*",
            "User-Agent": "Orangetheory/1 CFNetwork/1402.0.8 Darwin/22.2.0",
            "Accept-Language": "en-US,en;q=0.9",
            "X-Otf-Target": "UserAuthentication",
            "Content-Type": "application/x-amz-json-1.1",
        }

        data = {
            "ClientId": "65knvqta6p37efc2l3eh26pl5o",
            "AuthFlow": "USER_PASSWORD_AUTH",
            "AuthParameters": {
                "USERNAME": self.username,
                "PASSWORD": self.password
            }
        }

        response = requests.post(
            url="https://cognito-idp.us-east-1.amazonaws.com",
            headers=headers,
            json=data
        )
        response.raise_for_status()
        id_token = response.json().get('AuthenticationResult', {}).get('IdToken')
        
        return id_token
