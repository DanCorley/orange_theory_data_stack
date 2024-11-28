select
  version_hash
  , schema_name
  , version
  , engine_version
  , inserted_at
  , schema
from
  {{ source('dlt_metadata', '_dlt_version') }}
