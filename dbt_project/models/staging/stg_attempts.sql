{{ config(materialized='table',schema='stg') }}

with source as (
    select * from {{ ref('attempts') }}
),

statged_attempts as (  
    select
    player_name as player_name,
    club as club_name,
    position as position,
    total_attempts as total_attempts,
    on_target as on_target_attempts,
    off_target as off_target_attempts,
    blocked as blocked_attempts,
    match_played as matches
    from source
    where position = 'Forward'
)

select * from statged_attempts
