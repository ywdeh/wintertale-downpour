evie_auths:
    type: world
    debug: false
    events:
        on server start:
        - ~yaml load:is_linked_db.yml id:is_linked_db
        - ~discordconnect id:evie token:<secret[evie]>
        - ~discordmessage id:evie channel:<script[data_guild].data_key[channel_cross]> "### -# **<element[<&lt>:status:1396820745392226436<&gt>]> ИГРОВОЙ МИР ЗАПУЩЕН**"

        - ~webget https://raw.githubusercontent.com/InventivetalentDev/minecraft-assets/<server.bukkit_version.before[-]>/assets/minecraft/lang/ru_ru.json save:locale_minecraft_ru
        - if <entry[locale_minecraft_ru].failed.not>:
            - flag server locale_minecraft_ru:<util.parse_yaml[<entry[locale_minecraft_ru].result>]>