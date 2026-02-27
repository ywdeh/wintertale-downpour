tweaked_paintings:
    type: world
    debug: false
    addon: Tweaked Paintings
    addon_desc: <element[Облик картин теперь может быть изменен при взаимодействии:<n> 1. при отжатой shift, листает список картин вперед<n> 2. при зажатой shift, листает список картин назад]>
    events:
        on player right clicks painting:
        - ratelimit <player> 0.42s

        - if !<context.item.advanced_matches[air]>:
            - stop

        # 1x1
        - if <context.entity.painting_width.equals[1]> && <context.entity.painting_height.equals[1]>:
            - define 1x1 <list[kebab|aztec|alban|aztec2|bomb|plant|wasteland|meditative]>
            - if <player.is_sneaking>:
                - define painting <[1x1].get[<[1x1].find[<context.entity.painting>].sub[1]>].if_null[<[1x1].last>]>
                - if <[1x1].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[1x1].last>
            - else:
                - define painting <[1x1].get[<[1x1].find[<context.entity.painting>].add[1]>].if_null[<[1x1].first>]>

        # 1x2
        - if <context.entity.painting_width.equals[1]> && <context.entity.painting_height.equals[2]>:
            - define 1x2 <list[wanderer|graham|prairie_ride]>
            - if <player.is_sneaking>:
                - define painting <[1x2].get[<[1x2].find[<context.entity.painting>].sub[1]>].if_null[<[1x2].last>]>
                - if <[1x2].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[1x2].last>
            - else:
                - define painting <[1x2].get[<[1x2].find[<context.entity.painting>].add[1]>].if_null[<[1x2].first>]>

        # 2x1
        - if <context.entity.painting_width.equals[2]> && <context.entity.painting_height.equals[1]>:
            - define 2x1 <list[pool|courbet|sunset|sea|creebet]>
            - if <player.is_sneaking>:
                - define painting <[2x1].get[<[2x1].find[<context.entity.painting>].sub[1]>].if_null[<[2x1].last>]>
                - if <[2x1].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[2x1].last>
            - else:
                - define painting <[2x1].get[<[2x1].find[<context.entity.painting>].add[1]>].if_null[<[2x1].first>]>

        # 2x2
        - if <context.entity.painting_width.equals[2]> && <context.entity.painting_height.equals[2]>:
            - define 2x2 <list[match|bust|stage|void|skull_and_roses|wither|baroque|humble|earth|wind|fire|water]>
            - if <player.is_sneaking>:
                - define painting <[2x2].get[<[2x2].find[<context.entity.painting>].sub[1]>].if_null[<[2x2].last>]>
                - if <[2x2].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[2x2].last>
            - else:
                - define painting <[2x2].get[<[2x2].find[<context.entity.painting>].add[1]>].if_null[<[2x2].first>]>

        # 3x3
        - if <context.entity.painting_width.equals[3]> && <context.entity.painting_height.equals[3]>:
            - define 3x3 <list[bouquet|cavebird|cotan|endboss|fern|owlemons|sunflowers|tides|dennis]>
            - if <player.is_sneaking>:
                - define painting <[3x3].get[<[3x3].find[<context.entity.painting>].sub[1]>].if_null[<[3x3].last>]>
                - if <[3x3].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[3x3].last>
            - else:
                - define painting <[3x3].get[<[3x3].find[<context.entity.painting>].add[1]>].if_null[<[3x3].first>]>

        # 3x4
        - if <context.entity.painting_width.equals[3]> && <context.entity.painting_height.equals[4]>:
            - define 3x4 <list[backyard|pond]>
            - if <player.is_sneaking>:
                - define painting <[3x4].get[<[3x4].find[<context.entity.painting>].sub[1]>].if_null[<[3x4].last>]>
                - if <[3x4].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[3x4].last>
            - else:
                - define painting <[3x4].get[<[3x4].find[<context.entity.painting>].add[1]>].if_null[<[3x4].first>]>

        # 4x2
        - if <context.entity.painting_width.equals[4]> && <context.entity.painting_height.equals[2]>:
            - define 4x2 <list[fighters|changing|finding|lowmist|passage]>
            - if <player.is_sneaking>:
                - define painting <[4x2].get[<[4x2].find[<context.entity.painting>].sub[1]>].if_null[<[4x2].last>]>
                - if <[4x2].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[4x2].last>
            - else:
                - define painting <[4x2].get[<[4x2].find[<context.entity.painting>].add[1]>].if_null[<[4x2].first>]>

        # 4x3
        - if <context.entity.painting_width.equals[4]> && <context.entity.painting_height.equals[3]>:
            - define 4x3 <list[skeleton|donkey_kong]>
            - if <player.is_sneaking>:
                - define painting <[4x3].get[<[4x3].find[<context.entity.painting>].sub[1]>].if_null[<[4x3].last>]>
                - if <[4x3].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[4x3].last>
            - else:
                - define painting <[4x3].get[<[4x3].find[<context.entity.painting>].add[1]>].if_null[<[4x3].first>]>

        # 4x4
        - if <context.entity.painting_width.equals[4]> && <context.entity.painting_height.equals[4]>:
            - define 4x4 <list[pointer|pigscene|burning_skull|orb|unpacked]>
            - if <player.is_sneaking>:
                - define painting <[4x4].get[<[4x4].find[<context.entity.painting>].sub[1]>].if_null[<[4x4].last>]>
                - if <[4x4].find[<context.entity.painting>].sub[1].is_less_than_or_equal_to[0]>:
                    - define painting <[4x4].last>
            - else:
                - define painting <[4x4].get[<[4x4].find[<context.entity.painting>].add[1]>].if_null[<[4x4].first>]>

        - adjust <context.entity> painting:<[painting]>
        - animate arm_swing for:<player.location.find_players_within[32]>
        - playsound <context.entity.location> sound:entity.painting.place pitch:<util.random.decimal[1].to[1.2].round_to[1]> volume:0.6