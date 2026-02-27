tweaked_item_frames:
    type: world
    debug: false
    addon: Tweaked Item Frames
    addon_desc: <element[Рамки для предметов могут быть отредактированы с помощью ножниц:<n> 1. нажатие пкм по рамке изменит видимость рамки<n> 2. сквозь скрытые рамки теперь можно открывать сундуки, бочки и печи]>
    events:
        on player right clicks *item_frame with:!shears:
        - define cursor <player.cursor_on>
        - if !<context.entity.visible> && <context.entity.has_framed_item> && !<player.is_sneaking>:
            - if <[cursor].material.advanced_matches[*furnace|smoker|*chest|barrel]>:
                - determine cancelled passively
                - inventory open d:<[cursor]>

        on player right clicks *item_frame with:shears:
        - if !<player.is_sneaking>:
            - determine cancelled passively
            - ratelimit <player> 0.42s
            - itemcooldown <context.item.material.name> duration:0.42s

            - if <context.entity.location.has_flag[shearing_item_frames_queue]>:
                - queue <context.entity.location.flag[shearing_item_frames_queue]> stop
                - flag <context.entity> shearing_item_frames_queue:!
            - flag <context.entity.location> shearing_item_frames_queue:<queue> expire:6s

            - adjust <context.entity> visible:<context.entity.visible.not>
            - adjust <player> damage_item:[slot=hand;amount=1]

            - define sound <context.entity.visible.if_true[entity.item_frame.add_item].if_false[entity.item_frame.remove_item]>
            - playsound <context.entity.location> sound:<[sound]>
            - playsound <context.entity.location> sound:item.shears.snip pitch:<util.random.decimal[1].to[1.2].round_to[1]>
            - playeffect at:<player.eye_location.ray_trace[range=5;entities=*;ignore=<player>;fluids=true;nonsolids=true;default=air]> effect:crit quantity:<util.random.decimal[1].to[2].round_to[0]> offset:0.1

            - wait 3s
            - if !<context.entity.has_framed_item> && !<context.entity.visible>:
                - execute as_server "damage <context.entity.uuid> 1 minecraft:explosion" silent

        on *item_frame damaged:
        - if <context.entity.has_framed_item> && !<context.entity.visible>:
            - adjust <context.entity> visible:true