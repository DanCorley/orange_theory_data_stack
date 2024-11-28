select
  _dlt_id as dlt_record_id
  , member_uuid
  , _dlt_load_id
from
  {{ source('orange_theory_delta', 'heart_rate') }}
