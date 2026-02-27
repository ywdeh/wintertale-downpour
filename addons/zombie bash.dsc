zombie_bash:
    type: world
    debug: false
    addon: Zombie Bash
    addon_desc: <element[Помимо других оружий, некоторые зомби научились использовать щиты и блокировать атаки спереди. Зомби-жители могут орудовать щитами гораздо чаще]>
    events:
        # Shielded Zombie
        on zombie|zombie_villager spawns:
        - if <context.entity.type> matches ZOMBIE:
            - if <util.random_chance[7]>:
                - equip <context.entity> offhand:shield
        - else:
            - if <util.random_chance[45]>:
                - equip <context.entity> offhand:shield

        on zombie|zombie_villager damaged by player:
        - if <context.entity.item_in_offhand> matches Shield:
            - if !<context.entity.location.facing[<player>].degrees[90]>:
                - stop
            - if <util.random_chance[75]>:
                - define value 2
                - if <player.item_in_hand.material> matches *_sword|*_hoe|*_shovel|*_pickaxe|trident:
                    - define value <util.random.int[4].to[5]>
                - if <player.item_in_hand.material> matches *_axe:
                    - define value 10
                - determine cancelled passively
                - ratelimit <player> 0.4s
                - define location_eye <context.entity.eye_location>
                # Check mainhand
                # Flag manipulations
                - if !<context.entity.has_flag[shield_durability]>:
                    - flag <context.entity> shield_durability:0
                - flag <context.entity> shield_durability:+:<[value]>
                # Visual effects
                - playsound <[location_eye]> sound:item_shield_block
                - if <context.was_critical>:
                    - playeffect effect:crit at:<[location_eye]> quantity:18 data:0.4 offset:0.2
                    - playsound <context.entity.location> sound:ENTITY_PLAYER_ATTACK_CRIT
                - else:
                    - playeffect effect:crit at:<[location_eye]> quantity:4 data:0.4 offset:0.2
                - animate <context.entity> swing_off_hand
                - cast slow duration:0.5s amplifier:5 <context.entity> no_ambient hide_particles no_icon
                - random:
                    - adjust <context.entity> velocity:0.2,0.15,0
                    - adjust <context.entity> velocity:0,0.15,0.2
                    - adjust <context.entity> velocity:-0.2,0.15,0
                    - adjust <context.entity> velocity:0,0.15,-0.2
                # Broken shield behavior
                - if <context.entity.flag[shield_durability]> >= 10:
                    - flag <context.entity> shield_durability:!
                    - equip <context.entity> offhand:air
                    - animate <context.entity> animation:BREAK_EQUIPMENT_OFF_HAND
                    - playsound <context.entity.location> sound:ITEM_SHIELD_BREAK pitch:0.75
                    - playeffect effect:villager_angry at:<[location_eye]> quantity:2 data:0.4 offset:0.35