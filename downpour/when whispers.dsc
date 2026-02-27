when_whispers:
    type: command
    debug: false
    name: tell
    aliases:
    - minecraft:tell
    - minecraft:whisper
    - minecraft:w
    - minecraft:msg
    - whisper
    - w
    - msg
    tab completions:
        1: <server.online_players.parse[name]>
    tab complete:
        - inject task_get_locale
        - if <context.args.get[1].exists> and <context.args.get[1].advanced_matches[<server.online_players.parse[name]>]>:
            - determine <script[data_locale].data_key[chat_tags].get[<[me.locale]>].parsed>
    script:
    - define them.uuid <server.match_player[<context.args.get[1]>]> if:<context.args.get[1].exists.and[<server.match_player[<context.args.get[1]>].exists>]>

    - define me.uuid <player>
    - define me.message_split <context.args.get[2].to[256]> if:<context.args.get[2].exists>
    - define me.message_split_cache <[me.message_split]> if:<[me.message_split].exists>
    - inject task_get_locale

    - if <[them.uuid].exists> and <[me.message_split].exists>:
        - define me.message_accent_color <&5>
        - inject task_check_for_tags
        - inject task_check_for_curses
        - inject task_check_for_mentions
        - define me.message <[me.message_split].space_separated>
        - narrate targets:<[me.uuid]> "<&5><script[data_locale].data_key[whispers_to].get[<[me.locale]>]> <[them.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[them.uuid].name>].on_click[/w <[them.uuid].name> ].type[suggest_command]>: <[me.message].replace[*].with[⁎]>"

        - define me.message_split <[me.message_split_cache]>
        - define me.message_accent_color <&d>
        - inject task_check_for_tags
        - inject task_check_for_curses
        - inject task_check_for_mentions
        - define me.message <[me.message_split].space_separated>
        - narrate targets:<[them.uuid]> "<&d><[me.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[me.uuid].name>].on_click[/w <[me.uuid].name> ].type[suggest_command]> <script[data_locale].data_key[whispers_from].get[<[them.locale]>]>: <[me.message].replace[*].with[⁎]>"

    - else:
        - define command.issues:->:<script[data_locale].data_key[command_issue_unknown_player].get[<[me.locale]>]> if:<[them.uuid].exists.not>
        - define command.issues:->:<script[data_locale].data_key[command_issue_unknown_message].get[<[me.locale]>]> if:<[me.message_split].exists.not>

        - narrate "<&d><script[data_locale].data_key[command_issue].get[<[me.locale]>]>: <[command.issues].separated_by[, ]>"

command_ignore:
    type: command
    debug: false
    name: ignore
    script:
    - define them.uuid <server.match_player[<context.args.get[1]>]> if:<context.args.get[1].exists.and[<server.match_player[<context.args.get[1]>].exists>]>
    - define me.uuid <player>
    - define me.message_accent_color <&d>
    - inject task_get_locale

    - if <[them.uuid].exists>:
        - if <[me.uuid].has_flag[is_ignoring]> and <[me.uuid].flag[is_ignoring].contains[<[them.uuid]>]>:
            - flag <[me.uuid]> is_ignoring:<-:<[them.uuid]>
            - narrate "<&d><[them.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[them.uuid].name>].on_click[/w <[them.uuid].name> ].type[suggest_command]> <script[data_locale].data_key[ignore_remove].get[<[me.locale]>]>"

        - else:
            - flag <[me.uuid]> is_ignoring:->:<[them.uuid]>
            - narrate "<&d><[them.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[them.uuid].name>].on_click[/w <[them.uuid].name> ].type[suggest_command]> <script[data_locale].data_key[ignore_add].get[<[me.locale]>]>"

        - if <[me.uuid].flag[is_ignoring].size.is_more_than[3]>:
            - flag <[me.uuid]> is_ignoring:<[me.uuid].flag[is_ignoring].get[2].to[4]>

        - if <[me.uuid].flag[is_ignoring].equals[true]> or <[me.uuid].flag[is_ignoring].is_empty>:
            - flag <[me.uuid]> is_ignoring:!

    - else:
        - if <[me.uuid].has_flag[is_ignoring].not>:
            - define command.issues:->:<script[data_locale].data_key[command_issue_unknown_player].get[<[me.locale]>]> if:<[them.uuid].exists.not>
            - narrate "<&d><script[data_locale].data_key[command_issue].get[<[me.locale]>]>: <[command.issues].separated_by[, ]>"
        - else:
            - narrate "<&d><script[data_locale].data_key[ignore_list].get[<[me.locale]>]>:"
            - narrate "<&d> <[me.uuid].flag[is_ignoring].parse[name].separated_by[, ]>"
