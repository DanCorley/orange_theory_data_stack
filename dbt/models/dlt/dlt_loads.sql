select
  load_id
  , schema_name
  , status
  , inserted_at
  , schema_version_hash
from
  {{ source('dlt_metadata', '_dlt_loads') }}
