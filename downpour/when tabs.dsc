when_tabs:
    type: world
    debug: false
    events:
        on player joins:
        - inject task_form_tab
        on delta time secondly every:2:
        - inject task_form_tab

when_pings_server:
    type: world
    debug: false
    events:
        on server list ping:
        - define downpour.version <script[data_locale].data_key[downpour_version]>
        - determine version_name:<[downpour.version].to_lowercase> passively
        - define above "<&sp.repeat[2]><&gradient[from=#00AAFF;to=#00FDFF]><element[ᴡɪɴᴛᴇʀᴛᴀʟᴇ].underline><&8><&sp.repeat[37]><script[data_locale].data_key[downpour_version].to_lowercase.replace[own].with[].replace[our].with[]>"
        - define below "<&sp.repeat[2]><element[полу-классический сервер].color[<&[primary]>]>"
        - determine motd:<[above]><n><[below]> passively
        - determine max_players:100

task_form_tab:
    type: task
    debug: false
    script:
        - foreach <server.online_players> as:__player if:<server.online_players.is_empty.not>:
            - define me.uuid <player>
            - inject task_get_locale

            - define above "<&sp.repeat[<server.online_players.parse[name].parse[length].highest.add[17]>]><n><&gradient[from=#00AAFF;to=#00FDFF]><element[ᴡɪɴᴛᴇʀᴛᴀʟᴇ].underline><n>"
            - define below "<&sp>"
            - adjust <[me.uuid]> tab_list_info:<[above]>|<[below]>

            - define me.advancements <player.advancements.filter_tag[<[filter_value].contains[minecraft:recipe].not>].filter_tag[<[filter_value].contains[/root].not>].size>
            - adjust <[me.uuid]> "player_list_name:<&[primary]>⁎<[me.advancements]><&f> <[me.uuid].name>"