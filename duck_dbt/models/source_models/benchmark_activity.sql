select
  challenge_category_id
  , equipment_id
  , equipment_name
  , metric_entry__title
  , metric_entry__equipment_id
  , metric_entry__entry_type
  , metric_entry__metric_key
  , metric_entry__min_value
  , metric_entry__max_value
  , challenge_name
  , logo_url
  , best_record
  , last_record
  , previous_record
  , unit
  , _dlt_load_id
  , _dlt_id
from
  {{ source('orange_theory_delta', 'benchmark_activity') }}
