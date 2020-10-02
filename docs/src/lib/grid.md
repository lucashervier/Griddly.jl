# Grid
The grid instance is the core of Griddly. Indeed, it is from the grid object that
you load your games files: behaviors, objects, some levels of your game and so on.
You will create a game from the grid. Especially, all your actions are executed
in the grid.

## Functions
```@docs
Griddly.load!(gdy_reader::GDYReader,path_yaml_file::String)
Griddly.load_string!(gdy_reader::GDYReader,gdy_string::String)
Griddly.get_player_count(grid)
Griddly.get_all_available_actions(grid)
Griddly.get_player_available_actions(grid)
Griddly.get_non_player_available_actions(grid)
Griddly.get_input_ids(grid,action_name)
Griddly.get_player_actions_dict(grid)
Griddly.get_map_object_ids_char(grid)
Griddly.get_avatar_object(grid)
Griddly.load_level!(grid,lvl_number)
Griddly.load_level_string!(grid,lvl_string)
Griddly.vector_obs(grid)
Griddly.create_game(grid,observer::ObserverType)
```

## Simple example
