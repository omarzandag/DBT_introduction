{{ config(materialized='table',schema='stg') }}

WITH source as (
     select *
from {{ ref('disciplinary') }}
) ,

staged_disciplinary as (
    select 
    player_name as player_name,
    club as club_name,
    position as position,
    yellow as yellow_cards,
    red as red_cards,
    minutes_played as minutes_played
    from source
    where position = 'Forward'
)
select * from staged_disciplinary