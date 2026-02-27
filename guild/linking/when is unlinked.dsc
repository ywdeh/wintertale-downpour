player_not_linked:
    type: world
    debug: false
    events:
        on player flagged:!is_linked joins:
        - execute as_server "attribute <player.name> minecraft:block_break_speed base set 0" silent

        on player flagged:!is_linked changes food level:
        - determine cancelled passively

        on player flagged:!is_linked breaks block:
        - determine cancelled passively
        - showfake <context.location> air duration:2.6s
        - inject task_player_not_linked

        on player flagged:!is_linked clicks !air:
        - determine cancelled passively
        - inject task_player_not_linked

        on player flagged:!is_linked right clicks entity:
        - determine cancelled passively
        - inject task_player_not_linked

        on player flagged:i!s_linked breaks hanging:
        - determine cancelled passively
        - inject task_player_not_linked

        on player flagged:!is_linked picks up item:
        - determine cancelled passively

        on player flagged:!is_linked damages entity:
        - determine cancelled passively
        - inject task_player_not_linked

        on player flagged:!is_linked left clicks dragon_egg:
        - determine cancelled passively
        - inject task_player_not_linked

        on player damages player:
        - if !<player.has_flag[is_linked]> or !<context.entity.has_flag[is_linked]>:
            - determine cancelled passively
            - ratelimit <player> 0.18s
            - hurt 0.000001 <context.entity> cause:magic
            - if <context.entity.type> matches armor_stand:
                - animate <context.entity> for:<context.entity.location.find_players_within[32]> animation:armor_stand_hit

        after player flagged:!is_linked dies:
        - statistic take deaths 1

task_player_not_linked:
    type: task
    debug: FALSE
    script:
    - ratelimit <player> 1.8s
    - fakespawn <entity[text_display].with_map[<map[scale=0.4,0.4,0.4;pivot=center;default_background=true;opacity=4]>]> <player.eye_location.ray_trace[entities=*;ignore=<player>;fluids=true;nonsolids=true].forward[0.3]> save:1
    - wait 1.1t
    - adjust <entry[1].faked_entity> "text:<&[primary]>/link"
    - repeat 10:
        - wait 1t
        - adjust <entry[1].faked_entity> opacity:<element[<entry[1].faked_entity.opacity>].add[25]>
    - wait 1s
    - repeat 10:
        - wait 1t
        - adjust <entry[1].faked_entity> opacity:<element[<entry[1].faked_entity.opacity>].sub[25]>
    - remove <entry[1].faked_entity>