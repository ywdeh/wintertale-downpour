tweaked_double_doors:
    type: world
    debug: false
    addon: Tweaked Double Doors
    addon_desc: <element[Двойные двери из одного материала теперь открываются совместно или по одиночке при зажатой shift]>
    events:
        on player flagged:!set_tweaked_double_doors_disabled right clicks *_door:
        - if !<player.is_sneaking>:
            - foreach <context.location.center.find_blocks[<context.location.material.name>].within[1.1].exclude[<context.location>].filter_tag[<[filter_value].y.equals[<context.location.y>]>]> as:door:
                - if <context.location.material.hinge> not equals <[door].material.hinge> && <context.location.material.direction> equals <[door].material.direction> && <context.location.material.half> equals <[door].material.half> && <context.location.material.switched> equals <[door].material.switched>:
                    - switch <[door]>