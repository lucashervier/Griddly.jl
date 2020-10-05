using Griddly
using Random

image_path = joinpath(@__DIR__,"..","..","Griddly","resources","images");

shader_path = joinpath(@__DIR__,"..","..","Griddly","resources","shaders");

gdy_path = joinpath(@__DIR__,"..","..","Griddly","resources","games");

gdy_reader = Griddly.GDYReader(image_path,shader_path);

grid = Griddly.load!(gdy_reader,joinpath(gdy_path,"RTS/GriddlyRTS.yaml"))

# load a custom string
lvl_str = """ .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  M  M  M
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  M  M
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  M
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  M  W  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  M  W  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  H1 .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  W  M  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  B1 .  .  .  .  .  .  .  M  W  M  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  .  .  .  .  .  .  M  W  .  .  .  .  .  .  .  W  W  W  W  W  .  .  .  .
              .  .  .  .  W  W  W  W  W  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  B2 .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  W  M  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  W  M  .  .  .  .  .  .  .  .  H2 .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              .  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              M  .  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              M  M  .  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
              M  M  M  .  .  .  .  .  W  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
    """

game = Griddly.create_game(grid,Griddly.SPRITE_2D)

player1 = Griddly.register_player!(game,"Bob", Griddly.BLOCK_2D)
player2 = Griddly.register_player!(game,"Alice", Griddly.BLOCK_2D)

Griddly.init!(game)

Griddly.load_level_string!(grid,lvl_str)

Griddly.reset!(game)

# These are the actions we can use
global actions_map = Griddly.get_player_actions_dict(grid)

multiple_window = MultipleScreen(700,700;nb_scene=3)

for j in 1:1000
     x = rand(1:Griddly.get_width(grid))
     y = rand(1:Griddly.get_height(grid))

     action_choice = rand(1:length(actions_map))
     action_name = collect(keys(actions_map))[action_choice]
     action_id = rand(1:length(actions_map[action_name]))

     # Alternate between player_1 and player_2 actions
     if j % 2 == 0
         player_1_step_result = Griddly.step_player!(player1,action_name, [x, y, action_id])
     else
         player_2_step_result = Griddly.step_player!(player2,action_name, [x, y, action_id])
     end

    # Get all the observations
    player1_tiles = Griddly.get_data(Griddly.observe(player1))
    player2_tiles = Griddly.get_data(Griddly.observe(player2))
    sprites = Griddly.get_data(Griddly.observe(game))

    render_multiple(multiple_window,[player1_tiles,player2_tiles,sprites])
end
