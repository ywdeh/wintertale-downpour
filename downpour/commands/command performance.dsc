command_performance:
    type: command
    name: performance
    aliases:
    - perf
    - tps
    - ping
    debug: false
    script:
    - define me.uuid <player>
    - inject task_get_locale

    - narrate "<&d><script[data_locale].data_key[performance_details].get[<[me.locale]>]>:"
    - narrate "<&d> - <script[data_locale].data_key[performance_ping].get[<[me.locale]>]>: <[me.uuid].ping>"
    - narrate "<&d> - <script[data_locale].data_key[performance_tps].get[<[me.locale]>]>: <server.recent_tps.get[1].round_to[1]>, <server.recent_tps.get[2].round_to[1]>, <server.recent_tps.get[3].round_to[1]>"