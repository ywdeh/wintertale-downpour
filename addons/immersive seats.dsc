immersive_seats:
    type: world
    debug: false
    addon: Immersive Seats
    addon_desc: <element[Персонажи получают возможность садиться на любое доступное место:<n> - смотря под себя, shift + пкм<n><&color[#d5ddeb]>/set immersive-seats enabled/disabled]>
    events:
        on player flagged:!set_immersive_seats_disabled right clicks block type:!air with:air:
        - ratelimit <player> 1t
        - if <player.is_sneaking> and <player.vehicle.exists.not> and <player.location.pitch.is_more_than_or_equal_to[80]> and <player.location.below[0.05].simple> matches <context.location.simple>:
            - determine cancelled passively
            - playsound <player.location> <player.cursor_on.material.block_sound_data.get[step_sound]> pitch:<util.random.decimal[0.1].to[0.4].round_to[1]> volume:0.8
            - if <player.equipment.contains_match[!air]>:
                - playsound <player.location> sound:item.armor.equip_iron pitch:<util.random.decimal[0.1].to[0.4].round_to[1]> volume:0.8
            - spawn block_display <player.eye_location.ray_trace.with_yaw[<player.location.yaw>].with_pitch[<player.location.pitch>]> save:entity_seat
            - flag <player> is_sitting:true
            - flag <player> is_sitting_delay:true expire:0.64s
            - mount <player>|<entry[entity_seat].spawned_entity>

        on player flagged:!set_immersive_seats_disabled exits block_display:
        - if <player.is_online>:
            - if <player.has_flag[is_sitting_delay]>:
                - determine cancelled
            - playsound <player.location> <player.location.below[0.1].material.block_sound_data.get[step_sound]> pitch:<util.random.decimal[0.1].to[0.4].round_to[1]> volume:0.8
            - if <player.equipment.contains_match[!air]>:
                - playsound <player.location> sound:item.armor.equip_iron pitch:<util.random.decimal[0.1].to[0.4].round_to[1]> volume:0.8
            - teleport <player> <player.location.above[0.8]> relative
            - flag <player> is_sitting:!
            - remove <context.vehicle>
