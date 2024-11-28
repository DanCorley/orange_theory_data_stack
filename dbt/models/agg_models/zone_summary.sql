with zones_cte as (

  select
    booking_id
    , zone_time_minutes__gray as gray
    , zone_time_minutes__blue as blue
    , zone_time_minutes__green as green
    , zone_time_minutes__orange as orange
    , zone_time_minutes__red as red
  from
    {{ ref('performance_summaries') }}

)
, unpivot_cte as (

  unpivot zones_cte
    on gray, blue, green, orange, red
      into
        name zone
        value minutes_in_zone
)

select
  *
  , minutes_in_zone / sum(minutes_in_zone) over (
    partition by booking_id
  ) as percent_minutes_in_zone
from
  unpivot_cte
