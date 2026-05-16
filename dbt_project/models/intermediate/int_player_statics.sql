{{ config(materialized = 'table',schema='int') }}

with stg_goals as (
    select * from {{ ref('stg_goals') }}
),

stg_attempts as (
    select * from {{ ref('stg_attempts') }}
),

stg_disciplinary as (
    select * from {{ ref('stg_disciplinary') }}
),

stg_distribution as (
    select * from {{ ref('stg_distribution') }}
),

int_forwarders_stats as (
select 
    g.player_name as player_name,
    g.club_name as club_name,
    g.position as position,
    g.matches as matches,
    d.minutes_played as minutes_played,
    dist.passes_completed as passes_completed,
    dist.crosses_completed as crosses_completed,
    a.total_attempts as total_attempts,
    g.inside as inside,
    g.outside as outside,
    a.on_target_attempts as on_target,
    a.off_target_attempts as off_target,
    a.blocked_attempts as blocked,
    g.penalties as penalties,
    d.yellow_cards as yellow_cards,
    d.red_cards as red_cards,
    g.goals as goals
from stg_goals g join stg_attempts a on g.player_name = a.player_name and g.club_name = a.club_name
join stg_disciplinary d on g.player_name = d.player_name and g.club_name = d.club_name
join stg_distribution dist on g.player_name = dist.player_name and g.club_name = dist.club_name
order by
    g.goals desc
    )

select * from int_forwarders_stats