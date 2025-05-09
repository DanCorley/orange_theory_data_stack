select
  id as performance_summary_id
  , _bookings_id as booking_id
  , details__calories_burned as calories_burned
  , details__splat_points as splat_points
  , details__step_count as step_count
  , details__active_time_seconds as active_time_seconds
  , details__zone_time_minutes__gray as zone_time_minutes__gray
  , details__zone_time_minutes__blue as zone_time_minutes__blue
  , details__zone_time_minutes__green as zone_time_minutes__green
  , details__zone_time_minutes__orange as zone_time_minutes__orange
  , details__zone_time_minutes__red as zone_time_minutes__red
  , details__heart_rate__max_hr as max_hr
  , details__heart_rate__peak_hr as peak_hr
  , details__heart_rate__peak_hr_percent as peak_hr_percent
  , details__heart_rate__avg_hr as avg_hr
  , details__heart_rate__avg_hr_percent as avg_hr_percent
  , details__equipment_data__treadmill__avg_speed__display_value as treadmill__avg_speed_value
  , details__equipment_data__treadmill__avg_speed__display_unit as treadmill__avg_speed_unit
  , details__equipment_data__treadmill__max_speed__display_value as treadmill__max_speed_value
  , details__equipment_data__treadmill__max_speed__display_unit as treadmill__max_speed_unit
  , details__equipment_data__treadmill__avg_incline__display_value as treadmill__avg_incline_value
  , details__equipment_data__treadmill__avg_incline__display_unit as treadmill__avg_incline_unit
  , details__equipment_data__treadmill__max_incline__display_value as treadmill__max_incline_value
  , details__equipment_data__treadmill__max_incline__display_unit as treadmill__max_incline_unit
  , details__equipment_data__treadmill__avg_pace__display_value as treadmill__avg_pace_value
  , details__equipment_data__treadmill__avg_pace__display_unit as treadmill__avg_pace_unit
  , details__equipment_data__treadmill__max_pace__display_value as treadmill__max_pace_value
  , details__equipment_data__treadmill__max_pace__display_unit as treadmill__max_pace_unit
  , details__equipment_data__treadmill__total_distance__display_value as treadmill__total_distance_value
  , details__equipment_data__treadmill__total_distance__display_unit as treadmill__total_distance_unit
  , details__equipment_data__treadmill__moving_time__display_value as treadmill__moving_time_value
  , details__equipment_data__treadmill__moving_time__display_unit as treadmill__moving_time_unit
  , details__equipment_data__treadmill__elevation_gained__display_value as treadmill__elevation_gained_value
  , details__equipment_data__treadmill__elevation_gained__display_unit as treadmill__elevation_gained_unit
  , details__equipment_data__rower__avg_power__display_value as rower__avg_power_value
  , details__equipment_data__rower__avg_power__display_unit as rower__avg_power_unit
  , details__equipment_data__rower__max_power__display_value as rower__max_power_value
  , details__equipment_data__rower__max_power__display_unit as rower__max_power_unit
  , details__equipment_data__rower__avg_speed__display_value as rower__avg_speed_value
  , details__equipment_data__rower__avg_speed__display_unit as rower__avg_speed_unit
  , details__equipment_data__rower__max_speed__display_value as rower__max_speed_value
  , details__equipment_data__rower__max_speed__display_unit as rower__max_speed_unit
  , details__equipment_data__rower__avg_pace__display_value as rower__avg_pace_value
  , details__equipment_data__rower__avg_pace__display_unit as rower__avg_pace_unit
  , details__equipment_data__rower__max_pace__display_value as rower__max_pace_value
  , details__equipment_data__rower__max_pace__display_unit as rower__max_pace_unit
  , details__equipment_data__rower__avg_cadence__display_value as rower__avg_cadence_value
  , details__equipment_data__rower__avg_cadence__display_unit as rower__avg_cadence_unit
  , details__equipment_data__rower__max_cadence__display_value as rower__max_cadence_value
  , details__equipment_data__rower__max_cadence__display_unit as rower__max_cadence_unit
  , details__equipment_data__rower__total_distance__display_value as rower__total_distance_value
  , details__equipment_data__rower__total_distance__display_unit as rower__total_distance_unit
  , details__equipment_data__rower__moving_time__display_value as rower__moving_time_value
  , details__equipment_data__rower__moving_time__display_unit as rower__moving_time_unit
  , ratable
  , class__starts_at_local
  , class__name
  , class__type
  , _dlt_load_id
  , _dlt_id as record_id
from
  {{ source('orange_theory_delta', 'performance_summaries') }}
