immersive_flower_pots:
    type: world
    debug: false
    addon: Immersive Flower Pots
    addon_desc: <element[Взаимодействие с цветочными горшками теперь сопровождается соответствующими звуками]>
    events:
        on player right clicks flower_pot:
        - if !<player.is_sneaking> and <server.vanilla_tagged_materials[flower_pots].replace_text[potted_].with[].contains[<context.item.material>]>:
            - playsound <context.location.center> sound:block.leaf_litter.place pitch:1 volume:0.5

        on player right clicks potted_*:
        - if !<server.vanilla_tagged_materials[flower_pots].replace_text[potted_].with[].contains[<context.item.material>]>:
            - playsound <context.location.center> sound:block.leaf_litter.break pitch:1 volume:0.5