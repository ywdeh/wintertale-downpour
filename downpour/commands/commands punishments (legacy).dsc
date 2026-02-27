# SUBEJCT TO REWRITE

command_ban:
    type: command
    name: ban
    debug: false
    enabled: true
    tab completions:
        1: <server.online_players.parse[name]>
        2: 15m|1h|1d|7d|1m|6m|1y
        3: причина
    script:
    - define me <player>
    - inject task_get_locale

    - if <context.source_type> matches server or <player.has_flag[is_mentor]>:
        - if <context.args.get[1].exists.not> or <context.args.get[2].exists.not>:
            - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

        - else:
            - if <server.match_offline_player[<context.args.get[1]>].exists>:
                - define them <server.match_offline_player[<context.args.get[1]>]>
            - if <[them].exists.not>:
                - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

            - else:
                - if <context.args.get[2].as[duration].exists>:
                    - define is_banned_duration <context.args.get[2].as[duration]>
                - if <[is_banned_duration].exists.not>:
                    - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

                - else:
                    - define is_banned_reason <context.args.get[3].exists.if_true[<context.args.get[3].to[16].space_separated>].if_false[причина не указана]>
                    - ban <[them]> expire:<[is_banned_duration]> "reason:<[is_banned_reason]>" source:<player.name.exists.if_true[<player.name>].if_false[dp-console]>
                    - define output <element[Вы забанили <[them].name.color[white]> на <[is_banned_duration].formatted.color[white]> (<[is_banned_reason].color[white]>)]>
                    - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_debug]> "-# **<player.name>** has issued **BAN** to <[them].name> for <[is_banned_duration].formatted_words> with the note: <[is_banned_reason]>"
    - else:
        - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

    - inject task_output

command_mute:
    type: command
    name: mute
    debug: false
    enabled: true
    tab completions:
        1: <server.online_players.parse[name]>
        2: 15m|1h|1d|7d|1m|6m|1y
    script:
    - define me <player>
    - inject task_get_locale

    - if <context.source_type> matches server or <player.has_flag[is_mentor]>:
        - if <context.args.get[1].exists.not> or <context.args.get[2].exists.not>:
            - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

        - else:
            - if <server.match_offline_player[<context.args.get[1]>].exists>:
                - define them <server.match_offline_player[<context.args.get[1]>]>
            - if <[them].exists.not>:
                - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

            - else:
                - if <context.args.get[2].as[duration].exists>:
                    - define is_muted_duration <context.args.get[2].as[duration]>
                - if <[is_muted_duration].exists.not>:
                    - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

                - else:
                    - flag <[them]> is_muted expire:<[is_muted_duration]>
                    - narrate targets:<[them]> "<&color[#d5ddeb]>Вы были замьючены <player.name.color[white]> (<[is_muted_duration].formatted.color[white]>)"
                    - define output <element[Вы замьютили <[them].name.color[white]> на <[is_muted_duration].formatted.color[white]>]>
                    - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_debug]> "-# **<player.name>** has issued **MUTE** to <[them].name> for <[is_muted_duration].formatted_words>"
    - else:
        - define output <script[data_locale].data_key[command_unknown].get[<[me.locale]>]>

    - inject task_output

task_output:
    type: task
    script:
    - narrate "<&color[#d5ddeb]><[output]>"