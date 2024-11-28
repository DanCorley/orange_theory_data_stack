select
  version
  , engine_version
  , pipeline_name
  , state
  , created_at
  , version_hash
  , _dlt_load_id
from
  {{ source('dlt_metadata', '_dlt_pipeline_state') }}
