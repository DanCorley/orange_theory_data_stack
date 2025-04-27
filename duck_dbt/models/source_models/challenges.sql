select
  challenge_category_id
  , challenge_sub_category_id
  , challenge_name
  , logo_url
  , _dlt_load_id
  , _dlt_id
from
  {{ source('orange_theory_delta', 'challenges') }} 