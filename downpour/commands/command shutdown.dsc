command_shutdown:
    type: command
    name: stop
    debug: false
    aliases:
    - stop
    - restart
    permission: evie.shutdown
    script:
    - kick <server.online_players> "reason:Иви перезагружает сервер"
    - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_cross]> "### -# **<element[<&lt>a:a_inactive:1468690802288103526<&gt>]> ПЕРЕЗАПУСКАЮ ИГРОВОЙ МИР...**" save:message_restart
    - adjust server shutdown