select
  id as booking_id
  , paying_studio_id
  , person_id
  , member_id as member_uuid
  , service_name
  , checked_in
  , cross_regional
  , late_canceled
  , intro
  , mbo_booking_id
  , mbo_unique_id
  , mbo_paying_unique_id
  , canceled
  , created_at
  , updated_at
  , ratable
  , workout__id as class_history_uuid
  , workout__calories_burned
  , workout__splat_points
  , workout__step_count
  , workout__active_time_seconds
  , workout__zone_time_minutes__gray
  , workout__zone_time_minutes__blue
  , workout__zone_time_minutes__green
  , workout__zone_time_minutes__orange
  , workout__zone_time_minutes__red
  , class__id
  , class__name
  , class__ot_base_class_uuid
  , class__type
  , class__starts_at_local
  , class__starts_at
  , class__studio__id
  , class__studio__name
  , class__studio__mbo_studio_id
  , class__studio__time_zone
  , class__studio__email
  , class__studio__address__line1
  , class__studio__address__city
  , class__studio__address__state
  , class__studio__address__country
  , class__studio__address__postal_code
  , class__studio__currency_code
  , class__studio__phone_number
  , class__studio__latitude
  , class__studio__longitude
  , class__coach__first_name
  , ratings__coach__id
  , ratings__coach__description
  , ratings__coach__value
  , ratings__class__id
  , ratings__class__description
  , ratings__class__value
  , _dlt_load_id
  , _dlt_id
from
  {{ source('orange_theory_delta', 'bookings') }}
