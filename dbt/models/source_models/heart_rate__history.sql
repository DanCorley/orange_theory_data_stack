select
  _dlt_id as dlt_record_id
  , _dlt_parent_id as dlt_parent_id
  , max_hr__type
  , max_hr__value
  , zones__gray__start_bpm
  , zones__gray__end_bpm
  , zones__blue__start_bpm
  , zones__blue__end_bpm
  , zones__green__start_bpm
  , zones__green__end_bpm
  , zones__orange__start_bpm
  , zones__orange__end_bpm
  , zones__red__start_bpm
  , zones__red__end_bpm
  , change_from_previous
  , change_bucket
  , assigned_at
  , _dlt_root_id
  , _dlt_list_idx
from
  {{ source('orange_theory_delta', 'heart_rate__history') }}
