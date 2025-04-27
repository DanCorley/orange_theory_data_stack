select
  challenge_category_id
  , challenge_sub_category_id
  , logo_url
  , challenge_name
  , _dlt_root_id
  , _dlt_parent_id
  , _dlt_list_idx
  , _dlt_id
from
  {{ source('orange_theory_delta', 'benchmark_activity__challenge_histories__benchmark_histories__linked_challenges') }} 