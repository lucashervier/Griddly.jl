# Render Tools
Documentation on the RenderTool provided with Griddly. The render tool is back-end with [__Makie__](http://makie.juliaplots.org/stable/)

## Simple Rendering on one Screen
### Functions
```@docs
RenderWindow
RenderWindow(width::Int,height::Int)
render(render_window::RenderWindow,observation;nice_render=false)
```
!!! warning
    For some reason, when you render a certain amount of observations the rendering
    will slow down. We recommand to open a new RenderWindow for every episode you play.
    We still work for a better solutions


### Example of use
First we initialize a Sokoban grid and game.
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
```

Now since we want to render a random play on Sokoban we will use the RenderWindow
as follows:

```jldoctest
julia> render_window = RenderWindow(700,700)

julia> sprites = convert(Array{Int,3},Griddly.get_data(Griddly.observe(game))))

julia> render(render_window,sprites)

julia> for j in 1:200
       dir = rand(1:4)

       reward, done = Griddly.step_player!(player1,"move", [dir])

       sprites = Griddly.observe(game)
       sprites = convert(Array{Int,3},Griddly.get_data(sprites))
       render(render_window,sprites)
       end
```

## MakieScreenshot
```@docs
save_frame(observation,resolution::Tuple{Int64,Int64},file_name::String;file_path="julia/img/",format=".png")
save_frame(scene::SceneLike,file_name::String;file_path="julia/img/",format=".png")
```

## VideoRecorder
### Functions
```@docs
VideoRecorder
VideoRecorder(resolution::Tuple{Int64,Int64},file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
VideoRecorder(scene::SceneLike,file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
start_video(video::VideoRecorder)
add_frame!(video::VideoRecorder,io::VideoStream,observation;speed=1e-4,nice_display=false,fast_display=false)
save_video(video::VideoRecorder,io::VideoStream)
```
!!! warning
    Saving videos is a slow process. It could be optimized but at present we did not
    find a way.

### How to use
Assuming that you run the configuration in the RenderTool example, here is an
example of how to record a random play on Sokoban

```jldoctests
julia> video = VideoRecorder((700,700),"test_video";saving_path="videos/")

julia> io = start_video(video)

julia> sprites = convert(Array{Int,3},Griddly.get_data(Griddly.observe(game))))

julia> add_frame!(video,io,sprites;fast_display=true)

julia> for j in 1:200
       dir = rand(1:4)

       reward, done = Griddly.step_player!(player1,"move", [dir])

       sprites = Griddly.observe(game)
       sprites = convert(Array{Int,3},Griddly.get_data(sprites))
       add_frame!(video,io,sprites;fast_display=true)
       end

julia> save_video(video,io)
```

## MultipleScreen
### Functions
```@docs
MultipleScreen
MultipleScreen(width,height;nb_scene=2)
render_multiple(screen::MultipleScreen,observations;nice_render=false)
```
### How to use
Assuming that you run the configuration in the RenderTool example, here is an
example of how to render both game sprite observations and player block observations

```jldoctests
julia> multiple_window = MultipleScreen(700,700;nb_scene=2)

julia> sprites = convert(Array{Int,3},Griddly.get_data(Griddly.observe(game))))

julia> player_tiles = convert(Array{Int,3},Griddly.get_data(Griddly.observe(player1))))

julia> render_multiple(multiple_window,[sprites,player_tiles];nice_render=true)

julia> for j in 1:200
       dir = rand(1:4)

       reward, done = Griddly.step_player!(player1,"move", [dir])

       sprites = Griddly.observe(game)
       sprites = convert(Array{Int,3},Griddly.get_data(sprites))

       player_tiles = Griddly.observe(player1)
       player_tiles = convert(Array{Int,3},Griddly.get_data(player_tiles))
       render_multiple(multiple_window,[sprites,player_tiles];nice_render=true)
       end
```
