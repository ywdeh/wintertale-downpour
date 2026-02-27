honorary_creepers:
    type: world
    debug: false
    addon: Honorary Creepers
    addon_desc: <element[Вместо разрушения полных блоков, взрывы криперов превращают их в ослабленные вариации, которые могут быть уничтожены повторным взрывом]>
    events:
        on *chest*|barrel|*_bed destroyed by explosion source_entity:creeper|tnt:
        - determine cancelled passively
        - inject Creeper_Explodes_Task
        - blockcrack <context.block> progress:6 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:5 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:4 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:3 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:2 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:1 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:0 players:<context.block.find_players_within[32]>

        on grass_block|*dirt* destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> dirt
                - modifyblock <context.block> coarse_dirt
            - inject Creeper_Explodes_Task
        on sand destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[50]>:
            - random:
                - modifyblock <context.block> suspicious_sand
                - modifyblock <context.block> sandstone
            - inject Creeper_Explodes_Task
        on gravel destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[50]>:
            - random:
                - modifyblock <context.block> suspicious_gravel
            - inject Creeper_Explodes_Task
        on red_sand destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[50]>:
            - random:
                - modifyblock <context.block> red_sandstone
            - inject Creeper_Explodes_Task
        on stone|andesite destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cobblestone
                - modifyblock <context.block> gravel
                - modifyblock <context.block> infested_cobblestone
            - inject Creeper_Explodes_Task
        # Bricks:
        on stone_bricks destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> infested_cracked_stone_bricks
                - modifyblock <context.block> cracked_stone_bricks
            - inject Creeper_Explodes_Task
        on deepslate_bricks destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cracked_deepslate_bricks
            - inject Creeper_Explodes_Task
        on deepslate_tiles destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cracked_deepslate_tiles
            - inject Creeper_Explodes_Task
        on nether_bricks destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cracked_nether_bricks
            - inject Creeper_Explodes_Task
        on polished_blackstone_bricks destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cracked_polished_blackstone_bricks
            - inject Creeper_Explodes_Task
        # Bricks end ^^^
        on deepslate destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - random:
                - modifyblock <context.block> cobbled_deepslate
                - modifyblock <context.block> infested_deepslate
            - inject Creeper_Explodes_Task
        on oak_log|spruce_log|birch_log|jungle_log|acacia_log|dark_oak_log|mangrove_log|cherry_log destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - if <util.random_chance[80]>:
            - modifyblock <context.block> <material[stripped_<context.block.material.name>].with_single[direction=<context.block.material.direction>]>
            - inject Creeper_Explodes_Task
        on *_door|*gate destroyed by explosion source_entity:creeper:
        - determine cancelled passively
        - switch <context.block> on
        - inject Creeper_Explodes_Task
        - inject Creeper_Explodes_Task
        - blockcrack <context.block> progress:6 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:5 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:4 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:3 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:2 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:1 players:<context.block.find_players_within[32]>
        - wait <util.random.decimal[0.2].to[0.8]>s
        - blockcrack <context.block> progress:0 players:<context.block.find_players_within[32]>

Creeper_Explodes_Task:
    type: task
    debug: false
    script:
    - playsound <context.block> sound:<context.block.material.block_sound_data.get[break_sound]> volume:0.5
    - playeffect <context.block.center.down> effect:block_crack special_data:<context.block.material.name> quantity:32 offset:0.3