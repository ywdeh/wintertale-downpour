command_link:
    type: command
    name: link
    aliases:
    - discord
    debug: false
    script:
    - if <player.has_flag[is_link_requested]> and <context.args.get[1].exists> and <context.args.get[1]> matches accept:
        - ~yaml id:is_linked_db set <player.uuid>:<player.flag[is_link_requested]>
        - ~yaml savefile:is_linked_db.yml id:is_linked_db
        - narrate "<&d>Вы привязались к @<discord_user[evie,<yaml[is_linked_db].read[<player.uuid>]>].name.if_null[???-contact-developers]>. Добро пожаловать!"
        - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_debug]> "-# <player.name> is now linked to <discord_user[evie,<player.flag[is_link_requested]>].mention>. I also changed their Discord nickname to <player.name><n>-# *<player.uuid> × <discord_user[evie,<player.flag[is_link_requested]>].id>*"
        - ~discord id:evie rename <player.name> user:<discord_user[evie,<player.flag[is_link_requested]>]> group:<discord_group[evie,<script[data_guild].data_key[guild_id]>]>
        - flag <player> is_link_requested:!
        - run task_synchronize_user
    - else:
        - narrate "<&d>Присоединитесь к Дискорду и привяжите аккаунт:"
        - narrate "<&d> 1. <element[нажмите].on_click[https://discord.gg/W69E9mBWGS].type[open_url].underline>, чтобы перейти по ссылке;"
        - narrate "<&d> 2. в первом доступном канале нажмите на синюю кнопку привязки"