"""
	RenderWindow
Main Structure to render the observation of a single game. It will open a Makie
window in which your observations will be display.
"""
mutable struct RenderWindow
	scene::SceneLike
	width::Int
	height::Int
	initialized::Bool
end

"""
	RenderWindow(width::Int,height::Int)
Create a window with a resolution size of (width,height) and open it.
"""
function RenderWindow(width::Int, height::Int)
	scene = Scene(resolution=(width,height),show_axis=false)
	display(scene)
	RenderWindow(scene,width,height,true)
end

"""
	render(render_window::RenderWindow,observation;nice_render=false)
Display to your open window the observation given as inputs. The nice_render set
to true will make the loading wheel disappear but it will slowdown the rendering
of numerous observations.
"""
function render(render_window::RenderWindow,observation;nice_render=false)
	if (!render_window.initialized)
		throw("Render Window is not initialized")
	end

	# observation is a 3d array with UInt8, we need to transform it into a rgb julia image
	img = ImageCore.colorview(RGB{N0f8},observation)

	if nice_render
		# add the image to scene
		update_cam!(image!(view(img, :, size(img)[2]:-1:1)))
	else
		# add the image to scene
		render_window.scene = image!(view(img, :, size(img)[2]:-1:1))
	    display(render_window.scene)
	end

	# if you want to see more than the last state you need to sleep for a few
	sleep(1e-5)
	# clear the stack of plots for memory purpose
    pop!(render_window.scene.plots)
end

"""
	save_frame(observation,resolution::Tuple{Int64,Int64},file_name::String;file_path="julia/img/",format=".png")
If you want to save a specific observation without rendering all the steps of an episode and without creating a RenderWindow.

__Supported Format__: .png, .jpeg, and .bmp
"""
function save_frame(observation,resolution::Tuple{Int64,Int64},file_name::String;file_path="julia/img/",format=".png")
	scene = Scene(resolution=resolution,show_axis=false)
	img = ImageCore.colorview(RGB{N0f8},observation)
	scene = image!(view(img, :, size(img)[2]:-1:1))
	Makie.save("$file_path$file_name$format",scene)
end

"""
	VideoRecorder
This Structure will help you to capture a video of your experiments. It will also
render but if you are just looking to render observations then you should use a
RenderWindow since it will be faster.
"""
mutable struct VideoRecorder
	scene::SceneLike
	fps::Int64
	format::String
	file_name::String
	saving_path::String
end

"""
	VideoRecorder(resolution::Tuple{Int64,Int64},file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
This function will create the scene and set all the parameters you need to save a video.

__Available Format__ are: .mkv,.mp4,.webm,.gif
"""
function VideoRecorder(resolution::Tuple{Int64,Int64},file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
	scene = Scene(resolution=resolution,show_axis=false)
	display(scene)
	VideoRecorder(scene,fps,format,file_name,saving_path)
end

"""
	VideoRecorder(scene::SceneLike,file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
This function will create the video recorder from an existing scene and set all the parameters you need to save a video.

__Available Format__ are: .mkv,.mp4,.webm,.gif
"""
function VideoRecorder(scene::SceneLike,file_name::String; fps=30 ,format=".mp4", saving_path="videos/")
	display(scene)
	VideoRecorder(scene,fps,format,file_name,saving_path)
end

"""
	start_video(video::VideoRecorder)
This function will return the video stream in which we will be able to add frames
"""
function start_video(video::VideoRecorder)
	return VideoStream(video.scene;framerate=video.fps)
end

"""
	add_frame!(video::VideoRecorder,io::VideoStream,observation;speed=1e-4,nice_display=false,fast_display=false)
Add the observation as a frame for our video. The nice display option set to true will render without a loading wheel
while recording. The fast display option set to true (both cannot be set to true or this one will be ignore) will render
faster but you will see a loading wheel (but not in the final video)
"""
function add_frame!(video::VideoRecorder,io::VideoStream,observation;speed=1e-4,nice_display=false,fast_display=false)
	# observation is a 3d array with UInt8, we need to transform it into a rgb julia image
	img = ImageCore.colorview(RGB{N0f8},observation)

	if nice_display
		# add the img to the scene
		update_cam!(image!(view(img, :, size(img)[2]:-1:1)))
	    # if you want to see more than the last state you need to sleep for a few
	    sleep(speed)
	elseif fast_display
		# add the img to the scene
		video.scene = image!(view(img, :, size(img)[2]:-1:1))
		display(video.scene)
		# if you want to see more than the last state you need to sleep for a few
	    sleep(speed)
	else
		# add the img to the scene
		video.scene = image!(view(img, :, size(img)[2]:-1:1))
	end

	# add the current frame to io
	recordframe!(io)
	# clear the stack of plots for memory purpose
	pop!(video.scene.plots)
end

"""
	save_video(video::VideoRecorder,io::VideoStream)
Save the video with the name, path and format you choose when building the VideoRecorder
"""
function save_video(video::VideoRecorder,io::VideoStream)
	Makie.save("$(video.saving_path)$(video.file_name)$(video.format)",io)
end

"""
	MultipleScreen
This Structure helps to render different observations on the same screen. For instance
you can render the game sprites observation and the player blocks observation.
"""
struct MultipleScreen
	scene::SceneLike
	width::Int
	height::Int
	nb_scene::Int
	subscenes::Array{SceneLike}
end

"""
	MultipleScreen(width,height;nb_scene=2)
Instantiate a screen of size (width,height) divided into nb_scene. The allocations of
the different position and size of subscreens is automatic.
"""
function MultipleScreen(width,height;nb_scene=2)
	scene = Scene(resolution=(width,height),show_axis=false)
	# now we have to discretize our screen into nb_scene
	# we first cut our screen along the longer between width and height
	subscenes = []
	if height >= width
		# the height of our cutting scenes will be y_bound
		y_bound = round(height/2)
		if nb_scene%2==0
			# if we got an even number of scene their width will be x_step
			x_step = round(width/(nb_scene/2))
			for j in 0:1
				for i in 0:((nb_scene/2)-1)
					subscene = Scene(scene,Rect(i*x_step,j*y_bound,x_step,y_bound))
					push!(subscenes,subscene)
				end
			end
		else
			# for an odd number of scene we got the upper screen scene's width
			x_step_up = round(width/((nb_scene+1)/2))
			for i in 0:(((nb_scene+1)/2)-1)
				subscene = Scene(scene,Rect(i*x_step_up,y_bound,x_step_up,y_bound))
				push!(subscenes,subscene)
			end
			# and the bottom screen scene's width
			x_step_down = round(width/((nb_scene+1)/2 - 1))
			for i in 0:(((nb_scene+1)/2)-2)
				subscene = Scene(scene,Rect(i*x_step_down,0,x_step_down,y_bound))
				push!(subscenes,subscene)
			end
		end
	else
		# the width of our cutting scenes will all be x_bound
		x_bound = round(width/2)
		if nb_scene%2==0
			# if we got an even number of scene their height will be y_step
			y_step = round(height/(nb_scene/2))
			for j in 0:1
				for i in 0:((nb_scene/2)-1)
					subscene = Scene(scene,Rect(j*x_bound,i*y_step,x_bound,y_step))
					push!(subscenes,subscene)
				end
			end
		else
			# for an odd number of scene we got the right screen scene's height
			y_step_right = round(height/((nb_scene+1)/2 - 1))
			for i in 0:(((nb_scene+1)/2)-2)
				subscene = Scene(scene,Rect(x_bound,i*y_step_right,x_bound,y_step_right))
				push!(subscenes,subscene)
			end
			# and the left screen scene's height
			y_step_left = round(height/((nb_scene+1)/2))
			for i in 0:(((nb_scene+1)/2)-1)
				subscene = Scene(scene,Rect(0,i*y_step_left,x_bound,y_step_left))
				push!(subscenes,subscene)
			end
		end
	end
	display(scene)
	return MultipleScreen(scene,width,height,nb_scene,subscenes)
end

"""
	render_multiple(screen::MultipleScreen,observations;nice_render=false)
The observations input is an array of the different observation you want to render on the same screen.
Provide this array always in the same order if you want to keep one's observation on the same subscreen.
If you set nice render option to true you will make disappear the loading wheel but it would be slower.
"""
function render_multiple(screen::MultipleScreen,observations;nice_render=false)
	if screen.nb_scene < length(observations)
		throw("You want to display more observations than you have available scene \n Initialize a MultipleScreen with more Scene")
	end
	for i in 1:length(observations)
		# observation is a 3d array with UInt8, we need to transform it into a rgb julia image
		img = ImageCore.colorview(RGB{N0f8},observations[i])
		image!(screen.subscenes[i],view(img, :, size(img)[2]:-1:1))
	end

	if nice_render
		update_cam!(screen.scene)
	else
		display(screen.scene)
	end
    # if you want to see more than the last state you need to sleep for a few
    sleep(1e-4)
	# empty the stack of the plots for memory purpose
	for i in 1:screen.nb_scene
    	pop!(screen.subscenes[i].plots)
	end
end

"""
	save_frames(observations,file_name::String;file_path="julia/img/",format=".png")
If you want to save your observations on a MultipleScreen
"""
function save_frames(observations,file_name::String;file_path="julia/img/",format=".png")
	screen = MultipleScreen(700,700;nb_scene=length(observations))
	for i in 1:length(observations)
		# observation is a 3d array with UInt8, we need to transform it into a rgb julia image
		img = ImageCore.colorview(RGB{N0f8},observations[i])
		image!(screen.subscenes[i],view(img, :, size(img)[2]:-1:1))
	end
	Makie.save("$file_path$file_name$format",screen.scene)
end
