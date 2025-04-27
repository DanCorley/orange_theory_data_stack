select
  studio_name
  , equipment_id
  , result
  , date_created
  , date_updated
  , class_time
  , class_id
  , substitute_id
  , weight_lbs
  , class_name
  , coach_name
  , coach_image_url
  , _dlt_root_id
  , _dlt_parent_id
  , _dlt_list_idx
  , _dlt_id
from
  {{ source('orange_theory_delta', 'benchmark_activity__challenge_histories__benchmark_histories') }} 