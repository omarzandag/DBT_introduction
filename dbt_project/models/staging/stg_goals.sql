
{{ config(materialized='table',schema='stg') }}
with source as (
    select * from {{ ref('goals') }}
),

staged_goals as (
    select 
    player_name as player_name,
    club as club_name,
    position as position,
    goals as goals,
    match_played as matches,
    inside_area as inside,
    outside_areas as outside,
    penalties as penalties
    from source
    where position = 'Forward'
)

select * from staged_goals
