button_link:
    type: task
    script:
    - define button_link <discord_button.with[id].as[button_link].with[label].as[Привязать аккаунт].with[style].as[primary]>
    - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_intro]> rows:<[button_link]> "-# Кнопка привязки Дискорда к игре"

modal_link:
    type: world
    debug: false
    events:
        on discord button clicked id:button_link:
        - ~yaml load:is_linked_db.yml id:is_linked_db
        - define modal_link <discord_text_input.with[id].as[modal_link_input].with[label].as[введите никнейм].with[style].as[short].with[placeholder].as[вы должны находиться на сервере]>
        - discordmodal interaction:<context.interaction> name:modal_link title:Иви rows:<[modal_link]>

        on discord modal submitted name:modal_link:
        - define me <context.values.get[modal_link_input]>
        - if <server.match_player[<[me]>].exists>:
            - define me <server.match_player[<[me]>]>
            - if <yaml[is_linked_db].read[<[me].uuid>].exists>:
                - discordinteraction reply interaction:<context.interaction> "Я не могу отправить запрос **<[me].name>**: аккаунт уже привязан" ephemeral
            - else:
                - discordinteraction reply interaction:<context.interaction> "Запрос для **<[me].name>** отправлен.<n>Пожалуйста, вернитесь в игру и подтвердите его" ephemeral
                - flag <[me]> is_link_requested:<context.interaction.user.id> expire:24m
                - narrate targets:<[me]> "<&d>Получен запрос привязки к Дискорду @<context.interaction.user.name>:"
                - narrate targets:<[me]> "<&d> - если это не вы, игнорируйте сообщение!"
                - narrate targets:<[me]> "<&d> - <element[нажмите].underline.on_click[link accept].type[run_command]>, чтобы принять запрос"
                - playsound tagets:<[me]> sound:block.note_block.xylophone pitch:0.8
        - else:
            - discordinteraction reply interaction:<context.interaction> "Я не могу отправить запрос **<[me]>**: игрок не в сети" ephemeral

task_synchronize_user:
    type: task
    debug: false
    script:
    - ~yaml load:is_linked_db.yml id:is_linked_db

    - define is_linked false
    - define is_in_guild false

    - if <yaml[is_linked_db].read[<player.uuid>].exists>:
        - define is_linked true
        - define @me <discord_user[evie,<yaml[is_linked_db].read[<player.uuid>]>]>
    - if <[@me].exists>:
        - define is_in_guild true

    # whether is linked
    - if !<[is_linked]>:
        - flag <player> is_linked:!

    # whether is linked but absent from guild member list
    - if <[is_linked]> and !<[is_in_guild]>:
        - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_debug]> "-# **<player.name>** has logged, but is absent from the guild member list. Sending instructions and revoking their access until they join back<n>-# (uuid-<player.uuid> × id-<[@me].id.if_null[(yaml)-<yaml[is_linked_db].read[<player.uuid>]>]>)"
        - flag <player> is_linked:!

    # whether is linked, is in the guild but has their name changed
    - if <[is_linked]> and <[is_in_guild]> and !<[@me].nickname[<script[data_guild].data_key[guild_id]>].equals[<player.name>]>:
        - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_debug]> "-# **<player.name>** has logged, but their name is unrecognized (<player.name> vs <[@me].nickname[<script[data_guild].data_key[guild_id]>]>). Attempted to fix it: <[@me].mention><n>-# (uuid-<player.uuid> × id-<[@me].id>)"
        - ~discord id:evie rename <player.name> user:<[@me]> group:<discord_group[evie,<script[data_guild].data_key[guild_id]>]>

    # whether passed all the checks
    - if <[is_linked]> and <[is_in_guild]> and <[@me].nickname[<script[data_guild].data_key[guild_id]>].equals[<player.name>]>:
        - flag <player> is_linked
        - execute as_server "attribute <player.name> minecraft:block_break_speed base reset" silent
        - ~discord id:evie add_role user:<[@me]> role:<script[data_guild].data_key[role_wanderer]> group:<script[data_guild].data_key[guild_id]>