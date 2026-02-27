honorary_endermen:
    type: world
    debug: false
    addon: Honorary Endermen
    addon_desc: <element[Странники Края больше не проявляют интерес к блокам на территории с положительным уровнем освещения]>
    events:
        on enderman changes block:
        - if <context.location.light.blocks> <= 0:
            - determine cancelled passively