select
  year
  , is_participated
  , in_progress
  , _dlt_root_id
  , _dlt_parent_id
  , _dlt_list_idx
  , _dlt_id
from
  {{ source('orange_theory_delta', 'challenges__years') }} 