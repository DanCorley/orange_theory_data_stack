select
  challenge_category_id
  , equipment_id
  , equipment_name
  , metric_entry__title
  , metric_entry__equipment_id
  , metric_entry__entry_type
  , metric_entry__metric_key
  , challenge_name
  , logo_url
  , best_record
  , last_record
  , previous_record
  , unit
  , goals__goal
  , goals__goal_period
  , goals__overall_goal
  , goals__overall_goal_period
  , goals__min_overall
  , _challenges_challenge_sub_category_id
  , _dlt_load_id
  , _dlt_id
  , challenge_sub_category_id
  , metric_entry__min_value
  , metric_entry__max_value
from
  {{ source('orange_theory_delta', 'challenge_activity') }} 