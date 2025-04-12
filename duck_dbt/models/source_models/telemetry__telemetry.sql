select
  _dlt_id as dlt_record_id
  , _dlt_parent_id as dlt_parent_id
  , relative_timestamp
  , hr
  , agg_splats
  , agg_calories
  , row_data__row_speed
  , row_data__row_pps
  , row_data__row_spm
  , row_data__agg_row_distance
  , row_data__row_pace
  , tread_data__tread_speed
  , tread_data__tread_incline
  , tread_data__agg_tread_distance
  , _dlt_list_idx
from
  {{ source('orange_theory_delta', 'telemetry__telemetry') }}
