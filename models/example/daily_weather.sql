with daily_weather as (
    select 
    date(time) AS daily_weather,
    weather,
    pressure,
    humidity,
    temp,
    clouds 
    from {{ source('demo', 'weather') }}
), daily_weather_agg as (
    select 
    daily_weather,
    weather,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    round(avg(temp),2) as avg_temp,
    round(avg(clouds),2) as avg_clouds  

    from
    daily_weather
    group by daily_weather,weather
    qualify row_number() over (partition by daily_weather order by count(weather) desc) = 1
)select * from daily_weather_agg