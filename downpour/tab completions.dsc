tab_complete_commands:
    type: world
    debug: false
    events:
        on player receives commands:
        - if <player.is_op.not>:
            - define me.commands <list[ignore|tell|whisper|w].include[link].include[performance].include[settings|set].include[i|inspect]>
            - define me.commands <[me.commands].include[]> if:<player.has_flag[is_mentor]>
            - determine <[me.commands]> passively

when_command_unknown:
    type: world
    debug: false
    events:
        on command unknown:
        - if <context.source_type> == player && !<player.is_op>:
            - determine none passively
            - define me.uuid <player>
            - inject task_get_locale

            - define command.issues:->:<script[data_locale].data_key[command_issue_unknown].get[<[me.locale]>]>
            - narrate "<&d><script[data_locale].data_key[command_issue].get[<[me.locale]>]>: <[command.issues].separated_by[, ]>"

tab_complete_chat:
    type: world
    debug: false
    events:
        after player joins:
        - inject task_get_locale
        - adjust <player> add_tab_completions:<script[data_locale].data_key[chat_tags].get[<[me.locale]>].parsed>

        after player locale change:
        - inject task_get_locale
        - adjust <player> add_tab_completions:<script[data_locale].data_key[chat_tags].get[<[me.locale]>].parsed>