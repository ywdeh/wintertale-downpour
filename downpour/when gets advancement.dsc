when_gets_advancement:
    type: world
    debug: false
    events:
        on player completes advancement:
        - determine <context.message.color[<&[primary]>]>

        on player dies:
        - determine <context.message.color[<&[primary]>]>