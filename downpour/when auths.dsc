when_auths:
    type: world
    debug: false
    events:
        on player joins:
        - determine none passively
        - define me.uuid <player>
        - define me.message_accent_color <&[primary]>

        - adjust <[me.uuid]> send_server_brand:<script[data_locale].data_key[downpour_version]>
        - foreach <server.online_players> as:__player:
            - execute as_server "team join wanderer <[me.uuid].name>" silent

        - if <[me.uuid].statistic[play_one_minute].is_less_than_or_equal_to[20]>:
            - define me.message_key <script[data_locale].data_key[auth_joins_first]>
        - else:
            - define me.message_key <script[data_locale].data_key[auth_joins].values.random>

        - foreach <server.online_players> as:them:
            - define them.uuid <[them]>
            - inject task_get_locale
            - define them.message "<[me.message_accent_color].if_null[]><[me.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[me.uuid].name>].on_click[/w <[me.uuid].name> ].type[suggest_command]> <[me.message_key].get[<[them.locale]>]>"
            - narrate targets:<[them.uuid]> <[them.message]>

        - if <[me.uuid].has_flag[is_mentor]>:
            - define me.emoji_style <element[<&lt>:login_radiant:1397250133070057552<&gt>]>
        - else:
            - define me.emoji_style <element[<&lt>:login:1396640483257880747<&gt>]>

        - define me.message "### -# **<[me.emoji_style]> <[me.message_key].get[ru].to_uppercase>**"
        - inject task_send_to_guild
        - inject task_synchronize_user

        on player quits:
        - determine none passively
        - define me.uuid <player>
        - define me.message_accent_color <&[primary]>
        - define me.message_key <script[data_locale].data_key[auth_quits].values.random>

        - foreach <server.online_players> as:them:
            - define them.uuid <[them]>
            - inject task_get_locale
            - define them.message "<[me.message_accent_color].if_null[]><[me.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[me.uuid].name>].on_click[/w <[me.uuid].name> ].type[suggest_command]> <[me.message_key].get[<[them.locale]>]>"
            - narrate targets:<[them.uuid]> "<[them.message]>"

        - define me.emoji_style <element[<&lt>:logout:1396640506141999124<&gt>]>

        - define me.message "### -# **<[me.emoji_style]> <[me.message_key].get[ru].to_uppercase>**"
        - inject task_send_to_guild