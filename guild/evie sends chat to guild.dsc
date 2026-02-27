task_send_to_guild:
    type: task
    debug: false
    definitions: me.message
    script:
    - if <discord_channel[evie,<script[data_guild].data_key[channel_cross]>].last_message.author.id> matches <script[data_guild].data_key[webhook_1_id]> or <script[data_guild].data_key[webhook_2_id]>:
        - if <discord_channel[evie,<script[data_guild].data_key[channel_cross]>].last_message.author.id> matches <script[data_guild].data_key[webhook_2_id]>:
            - define webhook https://<script[data_guild].data_key[webhook_1]>
        - else:
            - define webhook https://<script[data_guild].data_key[webhook_2]>
    - else:
        - define webhook https://<script[data_guild].data_key[webhook_1]>

    - definemap data:
        username: "<player.name>"
        avatar_url: https://mc-heads.net/head/<player.uuid>
        content: <[me.message]>
    - ~webget <[webhook]> headers:<map.with[Content-Type].as[application/json]> data:<[data].to_json>

evie_sends_chat_to_guild:
    type: world
    debug: false
    events:
        on discord message received:
        - if <context.channel.id.advanced_matches[<script[data_guild].data_key[channel_cross]>]>:
            - foreach <server.online_players> as:__player if:<context.new_message.author.is_bot.not>:
                - narrate "<&color[#d5ddeb]><context.new_message.author.nickname[evie,<script[data_guild].data_key[guild_id]>].on_hover[<&[primary]>@<context.new_message.author.name>]> (Дискорд): <context.new_message.text_stripped.substring[1,256]>"

        on player completes advancement:
        - if <context.advancement.contains_text[recipes].not> and <context.advancement.contains_text[root].not>:
            - define advancement_title <context.advancement.before[root].replace[/].with[.]>
            - define icon <player.has_flag[is_mentor].if_true[<element[<&lt>:achieve_radiant:1397266949251010610<&gt>]>].if_false[<element[<&lt>:achieve:1397266947120562237<&gt>]>]>
            - define me.message "### -# <[icon]> **ПОЛУЧАЕТ ДОСТИЖЕНИЕ ×<player.advancements.filter_tag[<[filter_value].contains[minecraft:recipe].not>].filter_tag[<[filter_value].contains[/root].not>].size>**<n>-# <element[<&lt>:blank:1071588731166924810<&gt>]> <server.flag[locale_minecraft_ru].get[advancements.<[advancement_title]>.title].if_null[?].to_lowercase>"
            - inject task_send_to_guild