immersive_snow:
    type: world
    debug: false
    enabled: true
    addon: Immersive Snow
    addon_desc: <element[Вместо исчезания, слои снега при потере опоры теперь падают вниз]>
    events:
        on snow physics:
        - define level <context.location.material.level>
        - if <context.location.down.material> matches air:
            - spawn falling_block[fallingblock_type=snow[level=<[level]>];fallingblock_drop_item=false] <context.location.center.down[0.5]> save:falling_snow
            - playeffect <context.location.center.down[1.5]> effect:falling_dust special_data:snow_block quantity:<util.random.decimal[2].to[4].round_down> offset:0.35,0.2,0.35
            - wait 2.4s
            - if <entry[falling_snow].spawned_entity.is_spawned>:
                - playeffect <entry[falling_snow].spawned_entity.location.center> effect:falling_dust special_data:snow_block quantity:<util.random.decimal[2].to[4].round_down> offset:0.35,0.2,0.35
                - remove <entry[falling_snow].spawned_entity>