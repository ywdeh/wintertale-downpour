command_addons:
    type: command
    debug: false
    name: addons
    aliases:
    - ver
    - version
    - pl
    - plugins
    script:
    - foreach <util.scripts.alphabetical> as:addon:
        - if <[addon].parsed_key[addon].exists>:
            - define enabled_addons:->:<element[<[addon].parsed_key[addon]>].on_hover[<[addon].parsed_key[addon_desc]>]>
    - narrate "<&d>Дополнения (<[enabled_addons].size>):"
    - wait 1t
    - narrate "<&d> - <[enabled_addons].separated_by[<n> - ]>"
    - wait 1t
    - narrate "<&d>Версия сервера:"
    - wait 1t
    - narrate "<&d> <script[data_locale].data_key[downpour_version].on_hover[<&d>based on Paper]> (<server.bukkit_version.before[-]>)"