tweaked_armor_stands:
    type: world
    debug: false
    addon: Tweaked Armor Stands
    addon_desc: <element[Стойки для брони могут быть отредактированы с помощью ножниц<n> 1. при отжатом shift:<n> - нажатие пкм по телу покажет/скроет руки<n> - нажатие пкм по плите покажет/скроет плиту<n> 2. при зажатом shift:<n>- нажатие по телу повернет стойку в вашу сторону<n> - нажатие по плите уменьшит/увеличит стойку]>
    events:
        on player right clicks armor_stand with:shears:
        - determine cancelled passively
        - ratelimit <player> 0.42s
        - itemcooldown <context.item.material.name> duration:0.42s

        - adjust <player> damage_item:[slot=hand;amount=1]
        - animate <player> animation:arm_swing for:<player.location.find_players_within[32]>
        - animate <context.entity> animation:armor_stand_hit for:<player.location.find_players_within[32]>
        - playsound <context.entity.location> sound:item.shears.snip pitch:<util.random.decimal[1].to[1.2].round_to[1]> volume:0.6
        - playeffect at:<player.eye_location.ray_trace[range=5;entities=*;ignore=<player>;fluids=true;nonsolids=true;default=air]> effect:crit quantity:<util.random.decimal[1].to[2].round_to[0]> offset:0.1

        - if <context.entity.is_small.if_true[<context.click_position.y.is_less_than_or_equal_to[0.4]>].if_false[<context.click_position.y.is_less_than_or_equal_to[0.8]>]>:
            - if <player.is_sneaking>:
                - adjust <context.entity> is_small:<context.entity.is_small.not>
            - else:
                - adjust <context.entity> base_plate:<context.entity.base_plate.not>
            - stop

        - if <context.entity.is_small.if_true[<context.click_position.y.is_more_than[0.4]>].if_false[<context.click_position.y.is_more_than[0.8]>]>:
            - if <player.is_sneaking>:
                - look <context.entity> <player.location>
            - else:
                - adjust <context.entity> arms:<context.entity.arms.not>
                - if !<context.entity.item_in_hand.advanced_matches[air]>:
                    - wait 0.41s
                    - animate <context.entity> animation:armor_stand_hit for:<player.location.find_players_within[32]>
                    - adjust <context.entity> arms:<context.entity.arms.not>
                - stop