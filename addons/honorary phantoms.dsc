honorary_phantoms:
    type: world
    debug: false
    addon: Honorary Phantoms
    addon_desc: <element[Фантомы больше не заинтересованы в игроках, находящихся в крупном радиусе от собственной точки возрождения (кровати)]>
    events:
        on phantom prespawns:
        - define them <context.location.find_players_within[38].get[1]>
        - if <[them].bed_spawn.exists> and <[them].location.distance[<[them].bed_spawn>].horizontal.is_less_than_or_equal_to[120]>:
            - determine cancelled passively

        on phantom spawns:
        - define them <context.location.find_players_within[38].get[1]>
        - if <[them].bed_spawn.exists> and <[them].location.distance[<[them].bed_spawn>].horizontal.is_less_than_or_equal_to[120]>:
            - determine cancelled passively