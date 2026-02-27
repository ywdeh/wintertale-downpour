when_chats:
    type: world
    debug: false
    events:
        on player chats:
        - determine cancelled passively

        - define me.uuid <player>
        - define me.message_split <context.message.split_args>
        - define me.message_accent_color <&[primary]>
        - define me.display "<[me.uuid].name.on_hover[<[me.message_accent_color].if_null[]>/w <[me.uuid].name>].on_click[/w <[me.uuid].name> ].type[suggest_command]>:"

        - define me.message <[me.message_split].space_separated>

        - inject task_get_locale
        - inject task_check_for_curses
        - inject task_check_for_mentions
        - inject task_check_for_tags

        - define me.message <[me.message_split].space_separated>
        - foreach <server.online_players> as:them:
            - if <[them].has_flag[is_ignoring].and[<[them].flag[is_ignoring].contains[<[me.uuid]>]>].not>:
                - narrate targets:<[them]> "<[me.display].color[<&[primary]>]> <[me.message]>"

        - define me.message_split_guild <[me.message_split]> if:<[me.message_split_guild].exists.not>
        - define me.message <[me.message_split_guild].space_separated.strip_color.replace[⁎].with[\*].replace[_].with[\_]>
        - inject task_send_to_guild

task_check_for_mentions:
    type: task
    debug: false
    script:
    - foreach <[me.message_split]> as:shard:
        - if <[shard].advanced_matches[<server.online_players.parse[name]>]>:
            - define me.mention <server.match_player[<[shard]>]>
            - define me.message_split <[me.message_split].replace[<[shard]>].with[<[me.mention].name.color[<[me.message_accent_color].if_null[]>].on_hover[<[me.message_accent_color].if_null[]>/w <[me.mention].name>].on_click[/w <[me.mention].name> ].type[suggest_command]>]>

task_check_for_curses:
    type: task
    debug: false
    script:
    - foreach <[me.message_split]> as:shard:
        - if <[shard].advanced_matches[<script[data_curses].data_key[curses]>]>:
            - define me.message_split <[me.message_split].replace_text[<[shard]>].with[<element[⁎].repeat[<[shard].length>]>]>

task_check_for_tags:
    type: task
    debug: false
    script:
    - if <[me.uuid].item_in_hand.advanced_matches[air].not> and <[me.message_split].equals[<list[!item]>]> or <[me.message_split].equals[<list[!предмет]>]>:
        - define me.item <[me.uuid].item_in_hand>
        - define me.item_name <[me.item].material.translated_name>
        - define me.item_quantity <[me.item].quantity> if:<[me.item].quantity.is_more_than[1]>

        - define me.message_tag:<[me.item_name].as[list]>
        - define me.message_tag:->:<[me.item_quantity]> if:<[me.item_quantity].exists>
        - define me.message_tag <element[<[me.message_accent_color].if_null[]><&lb><[me.message_tag].separated_by[, ]><&rb>].on_hover[<[me.item]>].type[show_item]>

        - define me.message_split_guild:<list[<[me.message_split]>].include[**<[me.message_tag]>**]>
        - define me.message_split:->:<[me.message_tag]>

    - if <[me.message_split].equals[<list[!waypoint]>]> or <[me.message_split].equals[<list[!wp]>]> or <[me.message_split].equals[<list[!метка]>]>:

        - define me.message_tag:<[me.uuid].location.x.truncate.as[list]>
        - define me.message_tag:->:<[me.uuid].location.y.truncate>
        - define me.message_tag:->:<[me.uuid].location.z.truncate>
        - define me.message_tag <element[<[me.message_accent_color].if_null[]><&lb><[me.message_tag].separated_by[, ]><&rb>].on_hover[<[me.message_accent_color].if_null[]><script[data_locale].data_key[copy].get[<[me.locale]>]>].on_click[<[me.message_tag].space_separated>].type[copy_to_clipboard]>

        - define me.message_split_guild:<list[<[me.message_split]>].include[**<[me.message_tag]>**]>
        - define me.message_split:->:<[me.message_tag]>