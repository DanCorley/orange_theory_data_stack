select
  challenge_objective
  , challenge_id
  , studio_id
  , studio_name
  , start_date
  , end_date
  , total_result
  , is_finished
  , _dlt_root_id
  , _dlt_parent_id
  , _dlt_list_idx
  , _dlt_id
from
  {{ source('orange_theory_delta', 'benchmark_activity__challenge_histories') }}
