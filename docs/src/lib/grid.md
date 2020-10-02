# Grid
The grid instance is the core of Griddly. Indeed, it is from the grid object that
you load your games files: behaviors, objects, some levels of your game and so on.
You will create a game from the grid. Especially, all your actions are executed
in the grid.

## Functions
```@docs
Griddly.load!
Griddly.load_string!
Griddly.get_player_count
Griddly.get_all_available_actions
Griddly.get_player_available_actions
Griddly.get_non_player_available_actions
Griddly.get_input_ids
Griddly.get_player_actions_dict
Griddly.get_map_object_ids_char
Griddly.get_avatar_object
Griddly.load_level!
Griddly.load_level_string!
Griddly.vector_obs
Griddly.create_game
```

## GDY File & Griddly Description YAML
If you want to know more about the GDY files and the Griddle description YAML to
set up your own games with your own mechanics please go to the [Griddly documentation webpage](https://griddly.readthedocs.io/en/latest/reference/GDY/index.html#)
