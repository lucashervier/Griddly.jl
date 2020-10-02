# Player
This player object will be registered to a game process. The game process will
allow the player to execute actions in the grid linked to the game process.
The number of player you register to a game should match the number of player
required by the corresponding grid.

## Functions
To know how to create a player please refer to [`Griddly.register_player!`](@ref)
```@docs
Griddly.step_player!
Griddly.observe(player)
```

## More example
```@contents
Pages = [
    "examples/minidroggo.md"
    "examples/sokoban.md"
    "examples/multiplayer.md"
]
```
