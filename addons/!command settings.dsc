command_settings:
    type: command
    debug: false
    name: settings
    aliases:
    - set
    tab completions:
        1: immersive_crafting|tweaked_double_doors|immersive_seats
        2: enabled|disabled|reset
    script:
    - define me <player>
    - inject task_get_locale

    - if <context.args.get[1].exists> or <context.args.get[1].is_empty.not>:
        - if <script[command_settings].data_key[tab completions].get[1].as[list].contains_any[<context.args.get[1]>]> and <context.args.get[2].exists>:

            - if <script[command_settings].data_key[tab completions].get[2].as[list].contains_any[<context.args.get[2]>]>:
                - if <context.args.get[1]> matches immersive_crafting:
                        - if <context.args.get[2].exists.not> or <context.args.get[2]> matches disabled:
                            - flag <player> set_immersive_crafting_disabled
                            - define output "Опция <context.args.get[1].color[white]> отключена"
                        - if <context.args.get[2]> matches enabled|reset:
                            - flag <player> set_immersive_crafting_disabled:!
                            - define output "Опция <context.args.get[1].color[white]> включена"

                - if <context.args.get[1]> matches tweaked_double_doors:
                        - if <context.args.get[2].exists.not> or <context.args.get[2]> matches disabled:
                            - flag <player> set_tweaked_double_doors_disabled
                            - define output "Опция <context.args.get[1].color[white]> отключена"
                        - if <context.args.get[2]> matches enabled|reset:
                            - flag <player> set_tweaked_double_doors_disabled:!
                            - define output "Опция <context.args.get[1].color[white]> включена"

                - if <context.args.get[1]> matches immersive_seats:
                        - if <context.args.get[2].exists.not> or <context.args.get[2]> matches disabled:
                            - flag <player> set_immersive_seats_disabled
                            - define output "Опция <context.args.get[1].color[white]> отключена"
                        - if <context.args.get[2]> matches enabled|reset:
                            - flag <player> set_immersive_seats_disabled:!
                            - define output "Опция <context.args.get[1].color[white]> включена"

            - else:
                - define output "<script[data_locale].data_key[command_unknown].get[<[me.locale]>]>"

        - else:
            - define output "<script[data_locale].data_key[command_unknown].get[<[me.locale]>]>"

    - else:
        - define output "<script[data_locale].data_key[command_unknown].get[<[me.locale]>]>"

    - narrate "<&d><[output]>"