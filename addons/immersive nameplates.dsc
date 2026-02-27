immersive_nameplates:
    type: world
    debug: false
    addon: Immersive Nameplates
    addon_desc: <element[Имена персонажей над головой теперь скрыты до момента взаимодействия (пкм)]>
    events:
        on player right clicks player|npc:
        - if !<player.has_flag[is_seeing_nameplate]> && !<context.entity.has_effect[invisibility]>:
            - flag <player> is_seeing_nameplate expire:2s
            - animate <player> animation:arm_swing for:<player.location.find_players_within[32]>

            - fakespawn <entity[text_display].with_map[<map[pivot=center;scale=0.9,0.9,0.9;opacity=4]>]> <context.entity.location.center> save:1
            - mount <entry[1].faked_entity>|<context.entity>
            - adjust <entry[1].faked_entity> translation:0,0.25,0
            - adjust <entry[1].faked_entity> background_color:0,0,0,30
            - wait 1.1t

            - adjust <entry[1].faked_entity> text:<&[w_white]><context.entity.name>
            - repeat 10:
                - wait 1t
                - adjust <entry[1].faked_entity> opacity:<element[<entry[1].faked_entity.opacity>].add[25]>
            - wait 1s
            - repeat 10:
                - wait 1t
                - adjust <entry[1].faked_entity> opacity:<element[<entry[1].faked_entity.opacity>].sub[25]>
            - remove <entry[1].faked_entity>
            - adjust <context.entity> passengers