select
  equipment_id
  , equipment_name
  , logo_url
  , _dlt_load_id
  , _dlt_id
from
  {{ source('orange_theory_delta', 'benchmarks') }} 