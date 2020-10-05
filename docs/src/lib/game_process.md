# [Game Process](@id game_process)
Game process object is what will make the connection between player(s) and the grid.
It is also that object that will get your observer data.

## Functions
To know how to create a game please refer to [`Griddly.create_game`](@ref)
```@docs
Griddly.register_player!
Griddly.get_num_players
Griddly.init!
Griddly.reset!
Griddly.observe(::Griddly.GameProcess)
```
## More example

- [`MiniGridDoggo`](@ref minigrid_doggo)
- [`MultiPlayerRTS`](@ref rts)
