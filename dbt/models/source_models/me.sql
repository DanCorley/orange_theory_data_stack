select
  id
  , member_uuid
  , email
  , phone_number
  , first_name
  , last_name
  , communication_preferences__email__marketing_opt_in as email__marketing_opt_in
  , communication_preferences__email__transactional_opt_in as email__transactional_opt_in
  , communication_preferences__sms__marketing_opt_in as sms__marketing_opt_in
  , communication_preferences__sms__transactional_opt_in as sms__transactional_opt_in
  , postal_code
  , date_of_birth
  , sex
  , locale
  , unit_of_measure
  , weight_unit
  , weight_value
  , height_unit
  , height_value
  , leaderboard_username
  , home_studio__id
  , home_studio__mbo_studio_id
  , home_studio__name
  , home_studio__status
  , home_studio__license_number
  , home_studio__country_code
  , home_studio__address__line1
  , home_studio__address__city
  , home_studio__address__state
  , home_studio__address__postal_code
  , home_studio__address__country
  , mbo_home_studio_id
  , mbo_client_id
  , mbo_unique_id
  , cognito_id
  , image_url
  , active_device__id
  , active_device__type
  , active_device__version
  , mailing_address__first_name
  , mailing_address__last_name
  , mailing_address__line1
  , mailing_address__city
  , mailing_address__state
  , mailing_address__country
  , mailing_address__postal_code
  , _dlt_load_id
  , _dlt_id
from
  {{ source('orange_theory_delta', 'me') }}
