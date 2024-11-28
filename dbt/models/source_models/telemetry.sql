select
  _dlt_id as dlt_record_id
  , _bookings_id as booking_id
  , class_history_uuid
  , class_start_time
  , member_uuid
  , max_hr
  , zones__gray__start_bpm
  , zones__gray__end_bpm
  , zones__blue__start_bpm
  , zones__blue__end_bpm
  , zones__green__start_bpm
  , zones__green__end_bpm
  , zones__orange__start_bpm
  , zones__orange__end_bpm
  , zones__red__start_bpm
  , zones__red__end_bpm
  , window_size
  , _dlt_load_id
from
  {{ source('orange_theory_delta', 'telemetry') }}
