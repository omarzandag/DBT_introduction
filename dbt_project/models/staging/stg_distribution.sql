{{ config(materialized = 'table',schema='stg') }}

WITH source as (
    select * from {{ ref('distributon') }}
),

staged_distribution as (
    select 
    player_name as player_name,
    club as club_name,
    position::VARCHAR as position,
    pass_completed::INT as passes_completed,
    cross_complted::INT as crosses_completed
    from source
    where position = 'Forward'
)

select * from staged_distribution