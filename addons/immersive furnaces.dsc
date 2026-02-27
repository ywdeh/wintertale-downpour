immersive_furnaces:
    type: world
    debug: false
    addon: Immersive Furnaces
    addon_desc: <element[По готовности предмета, работающая печь теперь испускает соответствующие частицы и звук]>
    events:
        on furnace|blast_furnace cooks item:
        - if <context.location.chunk.is_loaded>:
            - playsound <context.location> sound:entity.generic.extinguish_fire pitch:2 volume:0.2
            - playeffect effect:smoke_normal at:<context.location.center.add[<context.location.block_facing.x.div[1.5]>,0.2,<context.location.block_facing.z.div[1.5]>]> quantity:18 offset:0.1
            - playeffect effect:small_flame at:<context.location.center.add[<context.location.block_facing.x.div[1.5]>,0.35,<context.location.block_facing.z.div[1.5]>]> quantity:2 offset:0.1
            - playeffect effect:campfire_cosy_smoke at:<context.location.center.add[<context.location.block_facing.x.div[1.3]>,0.3,<context.location.block_facing.z.div[1.3]>]> quantity:1 offset:0.2 velocity:0,0.03,0
            - wait 0.6s
            - playeffect effect:small_flame at:<context.location.center.add[<context.location.block_facing.x.div[1.5]>,0.35,<context.location.block_facing.z.div[1.5]>]> quantity:2 offset:0.1
            - random:
                - playeffect effect:campfire_cosy_smoke at:<context.location.center.add[<context.location.block_facing.x.div[1.3]>,0.3,<context.location.block_facing.z.div[1.3]>]> quantity:1 offset:0.2 velocity:0,0.02,0
                - playeffect effect:small_flame at:<context.location.center.add[<context.location.block_facing.x.div[1.5]>,0.35,<context.location.block_facing.z.div[1.5]>]> quantity:2 offset:0.1

        on smoker cooks item:
        - if <context.location.chunk.is_loaded>:
            - playsound <context.location> sound:entity.generic.extinguish_fire pitch:2 volume:0.2
            - playeffect effect:smoke_normal at:<context.location.center.add[0,0.5,0]> quantity:18 offset:0.1
            - playeffect effect:small_flame at:<context.location.center.add[0,0.5,0]> quantity:2 offset:0.1
            - playeffect effect:campfire_cosy_smoke at:<context.location.center.add[0,0.5,0]> quantity:1 offset:0.2 velocity:0,0.03,0
            - wait 0.6s
            - playeffect effect:small_flame at:<context.location.center.add[0,0.5,0]> quantity:2 offset:0.1
            - random:
                - playeffect effect:campfire_cosy_smoke at:<context.location.center.add[0,0.5,0]> quantity:1 offset:0.2 velocity:0,0.02,0
                - playeffect effect:small_flame at:<context.location.center.add[0,0.5,0]> quantity:2 offset:0.1