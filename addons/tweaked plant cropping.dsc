tweaked_plant_cropping:
    type: world
    debug: false
    addon: Tweaked Plant Cropping
    addon_desc: <element[Помимо других растений, лоза теперь тоже может быть подстрижена, чтобы предотвратить ее разрастание]>
    events:
        on player right clicks vine with:shears:
        - ratelimit <player> 1t
        - if <player.is_sneaking.not> && <context.location.has_flag[is_plant_cropped].not>:
            - ratelimit <player> 0.42s
            - itemcooldown <context.item.material.name> duration:0.42s
            - animate <player> animation:arm_swing for:<player.location.find_players_within[32]>
            - adjust <player> damage_item:[slot=hand;amount=1]
            - flag <context.location> is_plant_cropped
            - playsound <context.location> sound:item.shears.snip pitch:<util.random.decimal[1].to[1.2].round_to[1]>

        on block spreads type:vine:
        - if <context.source_location.has_flag[is_plant_cropped]>:
            - determine cancelled passively

        after player breaks block:
        - if <context.location.has_flag[is_plant_cropped]>:
            - flag <context.location> is_plant_cropped:!

        after block destroyed by explosion:
        - if <context.location.has_flag[is_plant_cropped]>:
            - flag <context.location> is_plant_cropped:!

        after player places block:
        - if <context.location.has_flag[is_plant_cropped]>:
            - flag <context.location> is_plant_cropped:!