immersive_crafting:
    type: world
    debug: false
    addon: Immersive Crafting
    addon_desc: <element[Создание и переплавка предметов теперь сопровождается соответствующими им звуками<n><&color[#d5ddeb]>/set immersive-crafting enabled/disabled]>
    events:
        on player flagged:!set_immersive_crafting_disabled crafts item:
        - define material <context.item.material>
        - define amount <context.amount.is_more_than[7].if_true[3].if_false[1].if_null[1]>
        - inject task_ambient_crafting
        on player flagged:!set_immersive_crafting_disabled trades with merchant:
        - ratelimit <player> 1t
        - define material <context.trade.result.material>
        - define amount <context.trade.result.quantity.is_more_than[7].if_true[3].if_false[1].if_null[1]>
        - inject task_ambient_crafting
        on player flagged:!set_immersive_crafting_disabled takes item from furnace:
        - define material <context.item.material>
        - define amount <context.item.quantity.is_more_than[7].if_true[3].if_false[1].if_null[1]>
        - inject task_ambient_crafting

task_ambient_crafting:
    type: task
    debug: false
    script:
    # Global overrides:
    - if <[material]> matches *torch|*leather*:
        - inject craft_sounds_overrides
        - stop
    # Leaf sounds:
    - if <[material]> matches *dye|*honey*|*spider_eye*|magma_cream|*stew*|*melon*|*pumpkin*|ender_eye:
        - inject craft_sounds_leaf
        - stop
    # Food sounds:
    - if <[material]> matches bread|pumpkin_pie|cookie|cake|bone_meal|*apple*|*carrot*:
        - inject craft_sounds_food
        - stop
    # Metal sounds:
    - if <[material]> matches *iron*|*gold*|*diamond*|*emerald*|*netherite*|*copper*|*bucket*|*minecart*|shears|brush|flint_and_steel:
        - inject craft_sounds_metal
        - stop
    # Wooden sounds:
    - if <[material]> matches *wood*|*oak*|*spruce*|*jungle*|*birch*|*acacia*|*mangrove*|*cherry*|*crimson*|*warped*:
        - inject craft_sounds_wood
        - stop
    # Stone sounds:
    - if <[material]> matches *stone*|*coal*:
        - inject craft_sounds_stone
        - stop
    # If nothing fits, rest:
    - inject craft_sounds_rest

Craft_Sounds_Particles:
    type: task
    debug: false
    script:
    - if <player.cursor_on[5].if_null[<player.location>].material> matches crafting_table:
        - playeffect <player.cursor_on.center.down[0.4]> effect:block_crack special_data:<player.cursor_on.material.name> offset:0.2,0.05,0.2 quantity:2

Craft_Sounds_Overrides:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material]> matches *torch:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_bamboo_fall volume:0.8 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.4 pitch:<util.random.decimal[0.6].to[0.8].round_to[1]>
        - if <[material]> matches *leather*:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:ENTITY_VILLAGER_WORK_LEATHERWORKER volume:0.4 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.8 pitch:<util.random.decimal[0.6].to[0.8].round_to[1]>
        - wait 0.125s

Craft_Sounds_Leaf:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - playsound <player.cursor_on[5].if_null[<player.location>]> sound:ITEM_INK_SAC_USE volume:0.35 pitch:<util.random.decimal[1.1].to[1.5].round_to[1]>
        - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_vine_fall volume:0.25 pitch:<util.random.decimal[1.5].to[1.7].round_to[1]>
        - wait 0.125s

Craft_Sounds_Food:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material].block_sound_data.exists>:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:<[material].block_sound_data.get[place_sound]>
        - else:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_moss_carpet_fall volume:0.6 pitch:<util.random.decimal[0.8].to[1.0].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.4 pitch:<util.random.decimal[0.6].to[0.8].round_to[1]>
        - wait 0.125s

Craft_Sounds_Metal:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material].block_sound_data.exists>:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:<[material].block_sound_data.get[place_sound]>
            - if <[material]> matches *diamond*|*emerald*:
                - playsound <player.cursor_on[5].if_null[<player.location>]> sound:BLOCK_AMETHYST_CLUSTER_FALL pitch:2 volume:0.6
        - else:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_netherite_block_fall volume:0.8 pitch:<util.random.decimal[1.2].to[1.4].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_bamboo_break volume:0.25 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - if <[material]> matches *diamond*|*emerald*:
                - playsound <player.cursor_on[5].if_null[<player.location>]> sound:BLOCK_AMETHYST_CLUSTER_FALL pitch:2 volume:0.6
        - wait 0.125s

Craft_Sounds_Wood:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material].block_sound_data.exists>:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:<[material].block_sound_data.get[place_sound]>
        - else:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_bamboo_fall volume:0.8 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.4 pitch:<util.random.decimal[0.6].to[0.8].round_to[1]>
        - wait 0.125s

Craft_Sounds_Stone:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material].block_sound_data.exists>:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:<[material].block_sound_data.get[place_sound]>
        - else:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_deepslate_tiles_fall volume:0.8 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.4 pitch:<util.random.decimal[0.6].to[0.8].round_to[1]>
        - wait 0.125s

Craft_Sounds_Rest:
    type: task
    debug: false
    script:
    - repeat <[amount]>:
        - if <[material].block_sound_data.exists>:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:<[material].block_sound_data.get[place_sound]>
        - else:
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:block_bamboo_fall volume:0.6 pitch:<util.random.decimal[0.8].to[1.2].round_to[1]>
            - playsound <player.cursor_on[5].if_null[<player.location>]> sound:item_bundle_insert volume:0.4 pitch:<util.random.decimal[1].to[1.2].round_to[1]>
        - wait 0.125s