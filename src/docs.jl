"""
    Griddly.load!(gdy_reader::Griddly.GDYReader,path_yaml_file::String)
The output of this function is the corresponding grid of your yaml file. The
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
    Griddly.load_string!(gdy_reader::Griddly.GDYReader,gdy_string::String)
Same as Griddly.load!() except that instead of providing the path to your game
yaml file you can give as input the corresponding string
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
Will instantiate a game from the grid and define the observer type.
"""
Griddly.create_game
