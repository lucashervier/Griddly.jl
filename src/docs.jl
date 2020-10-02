"""
    Griddly.load!(gdy_reader::GDYReader,path_yaml_file::String)
The output of this function is the corresponding grid of your GDY file. The
GDYReader will also link the images and shaders ressources to the objects in your
grid.

```jldoctest
julia> using Griddly

julia> image_path = joinpath(@__DIR__,"..","resources","images");

julia> shader_path = joinpath(@__DIR__,"..","resources","shaders");

julia> gdy_path = joinpath(@__DIR__,"..","resources","games");

julia> gdy_reader = Griddly.GDYReader(image_path,shader_path);

julia> grid = Griddly.load!(gdy_reader,joinpath(gdy_path,"Single-Player/GVGAI/sokoban.yaml"))
```
"""
Griddly.load!

"""
    Griddly.load_string!(gdy_reader::GDYReader,gdy_string::String)
Same as Griddly.load!() except that instead of providing the path to your game
GDY file you can give as input the corresponding string
"""
Griddly.load_string!

"""
    Griddly.get_player_count(grid)
Will return the number of player required to play any game from the grid
"""
Griddly.get_player_count

"""
    Griddly.get_all_available_actions(grid)
This will return all the actions name enable in this grid. Actions available for
the player or for other objects in the grid (example: ennemies random walk)
"""
Griddly.get_all_available_actions

"""
    Griddly.get_player_available_actions(grid)
Get action names that the player can execute
"""
Griddly.get_player_available_actions

"""
    Griddly.get_non_player_available_actions(grid)
Get action names that only other objects than the agent in the grid can do
"""
Griddly.get_non_player_available_actions

"""
    Griddly.get_input_ids(grid,action_name)
Each action can have several sub-actions. For instance, your action name can be
"move" and you can go LEFT,UP,RIGHT or DOWN. With this example, the output will
be [1,2,3,4] corresponding to each directions
"""
Griddly.get_input_ids

"""
    Griddly.get_player_actions_dict(grid)
This will get you a dictionnary where the keys are the action name available for
an agent and where corresponding value is the list of possible ids for this action.
"""
Griddly.get_player_actions_dict

"""
    Griddly.get_map_object_ids_char(grid)
Will get you the mapping between an object id and the corresponding character used
to represent it in the GDY file
"""
Griddly.get_map_object_ids_char

"""
    Griddly.get_avatar_object(grid)
If the avatar's name is defined in your GDY file it will return it
"""
Griddly.get_avatar_object

"""
    Griddly.load_level!(grid,lvl_number)
This will set the current level in the grid to the level index corresponding to
lvl number in your GDY file
"""
Griddly.load_level!

"""
    Griddly.load_level_string!(grid,lvl_string)
This will set the current level in the grid define by the string you provided. For
instance if we say we have load the sokoban grid as in the Griddly.load! example
we can do:
```jldoctest
julia> lvl_str ="       wwwww
                        w...w
                        wh.hw
                        wh.bw
                        wb.Aw
                        w...w
                        wwwww
                "
julia> Griddly.load_level_string!(grid,lvl_string)
```
"""
Griddly.load_level_string!

"""
    Griddly.vector_obs(grid)
This will return a Vector observation of the current state of the grid. If you
want to know more about Vector observation see the Observer section.
"""
Griddly.vector_obs

"""
    Griddly.create_game(grid,observer::ObserverType)
Will instantiate a game from a grid and define the observer type.
```jldoctest
julia> game = Griddly.create_game(grid,Griddly.SPRITE_2D)
```
"""
Griddly.create_game

"""
    Griddly.register_player!(game,player_name,observer_type)
This function will create and register a player in the current game. Especially,
a player can get his own __ObserverType__. Moreover, the player only got a partial
observation of the grid.
```jldoctest
julia> player = Griddly.register_player!(game,"Tux",Griddly.BLOCK_2D)
```
"""
Griddly.register_player!

"""
    Griddly.get_num_players(game)
This will get you the number of player registered for your game instance
"""
Griddly.get_num_players

"""
    Griddly.init!(game)
Will initialize the game, connect the dot with the grid which you created
your game from, it also configure both game observer(global observer) and
all players observer (partial observer).
"""
Griddly.init!

"""
    Griddly.reset!(game)
Will reset the grid to the initial configuration of the last level you loaded in.
Will also reset positions and parameters of all the observers.
"""
Griddly.reset!

"""
    Griddly.observe(game)
Will return a NumpyWrapper object of, depending on your __ObserverType__, representing the current state of the grid.
If you want to get the data of those observation you can use: `Griddly.get_data(observation)`. If you only want to get the shape
of your observations you can use: `Griddly.get_shape(observation)`. The shape will depends on your __ObserverType__.

Example:
```jldoctest
julia> using Griddly

julia> image_path = joinpath(@__DIR__,"..","resources","images");

julia> shader_path = joinpath(@__DIR__,"..","resources","shaders");

julia> gdy_path = joinpath(@__DIR__,"..","resources","games");

julia> gdy_reader = Griddly.GDYReader(image_path,shader_path);

julia> grid = Griddly.load!(gdy_reader,joinpath(gdy_path,"Single-Player/GVGAI/sokoban.yaml"))

julia> game = Griddly.create_game(grid,Griddly.SPRITE_2D)

julia> player1 = Griddly.register_player!(game,"Tux", Griddly.BLOCK_2D)

julia> Griddly.init!(game)

julia> Griddly.load_level!(grid,1)

julia> Griddly.reset!(game)

julia> initial_sprites = convert(Array{Int,3},Griddly.get_data(Griddly.observe(game))))
```
"""
Griddly.observe(::Griddly.GameProcess)

"""
    Griddly.step_player!(player,action_name,[actions_array])
This will make your player perform the action defined by action name with the ids
of actions array. For instance, let's say you want your player to move to the LEFT
and then UP you will do:
```jldoctest
julia> Griddly.step_player!(player1,"move",[1 2])
```
Indeed, the 1st id of "move" is LEFT and 2 is UP.
"""
Griddly.step_player!

"""
    Griddly.observe(player)
Will return a NumpyWrapper object of, depending on the __ObserverType__ you
attached to your player, representing partially (from player point of view) the
current state of the grid. If you want to get the data of those observation you
can use: `Griddly.get\_data(observation)`.If you only want to get the shape of your
observations you can use: `Griddly.get\_shape(observation)`. The shape will depends
on your __ObserverType__.

Example:
```jldoctest
julia> using Griddly

julia> image_path = joinpath(@__DIR__,"..","resources","images");

julia> shader_path = joinpath(@__DIR__,"..","resources","shaders");

julia> gdy_path = joinpath(@__DIR__,"..","resources","games");

julia> gdy_reader = Griddly.GDYReader(image_path,shader_path);

julia> grid = Griddly.load!(gdy_reader,joinpath(gdy_path,"Single-Player/GVGAI/sokoban.yaml"))

julia> game = Griddly.create_game(grid,Griddly.SPRITE_2D)

julia> player1 = Griddly.register_player!(game,"Tux", Griddly.BLOCK_2D)

julia> Griddly.init!(game)

julia> Griddly.load_level!(grid,1)

julia> Griddly.reset!(game)

julia> initial_player_tiles = convert(Array{Int,3},Griddly.get_data(Griddly.observe(player1))))
```
"""
Griddly.observe(::Griddly.Player)
