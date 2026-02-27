immersive_leaf_decay:
    type: world
    debug: false
    addon: Immersive Leaf Decay
    addon_desc: <element[Распадающаяся листва теперь испускает дополнительные частицы и звук]>
    events:
        on leaves decay:
        - playeffect <context.location.center> effect:tinted_leaves special_data:[color=<&color[<context.location.biome.foliage_color>]>] quantity:<util.random.decimal[2].to[6].round_down> offset:0.5,0.15,0.5
        - playsound <context.location.center> sound:block.leaf_litter.fall volume:0.6 pitch:<util.random.decimal[0.8].to[1.4].round_to[1]>