with trips as (
    select 
    ride_id,
    DATE(TO_TIMESTAMP(started_at)) as trip_date,
    start_statio_id as start_station_id,
    END_STATION_ID,
    member_csual as member_casual,
    timestampdiff(second,to_timestamp(started_at),to_timestamp(ended_at)) AS trip_duration_seconds

    from {{ ref('stg_bike') }}
    where ride_id!='ride_id'
) select * from trips