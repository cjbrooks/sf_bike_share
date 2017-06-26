select
  t1.*,
  t2.start_station,
  t2.start_terminal,
  t3.end_station,
  t3.end_terminal
from
(select
  fact_trips.id as trip_id,
  fact_trips.duration,
  fact_trips.start_date,
  fact_trips.end_date,
  fact_trips.bike_id,
  dim_entity.type as subscriber_type,
  dim_entity_zip.zip_code as zip_code
from
  fact_trips
join
  dim_entity on fact_trips.entity_id = dim_entity.id
join
  dim_entity_zip on dim_entity_zip.entity_id = dim_entity.id) as t1
join on t1.trip_id = t2.id
(select
  fact_trips.id,
  dim_stations.station_name as start_station,
  dim_stations.terminal_name as start_terminal
from
  dim_stations
join
  fact_trips
on
  dim_stations.id = fact_trips.start_station_id) as t2
join on t1.trip_id = t3.id
(select
  fact_trips.id,
  dim_stations.station_name as end_station,
  dim_stations.terminal_name as end_terminal
from
  dim_stations
join
  fact_trips
on
  dim_stations.id = fact_trips.end_station_id) as t3

where t1.start_date >= '2014-3-1' and t1.start_date < '2014-9-1'
