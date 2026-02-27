tweaked_stonecutter:
    type: world
    debug: false
    addon: Tweaked Stonecutter
    addon_desc: <element[Персонажи, стоя на лезвии камнереза, будут получать урон]>
    events:
        after player steps on stonecutter:
        - inject task_tweaked_stonecutter

task_tweaked_stonecutter:
    debug: false
    type: task
    script:
    - if <player.gamemode> matches survival:
        - hurt <player> 3
        - playsound <player.location> sound:ui_stonecutter_take_result volume:0.3 pitch:1.8
        - playeffect effect:damage_indicator at:<player.location> quantity:2 offset:0.2
        - wait 1s
        - if <player.location.material.name> matches stonecutter:
            - inject task_tweaked_stonecutter