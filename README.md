# Griddly.jl

A julia wrapper for [Griddly](https://github.com/Bam4d/Griddly) which is an amazing framework for AI research.

Work is in progress in order to simply add this package through your REPL.

In the meantime if you want to use Griddly with Julia this is how you should proceed:

## Build the C++ side 

To do that you have to first get the [Griddly Julia branch repo](https://github.com/luhervier/Griddly/tree/dev-julia-1).

Once you cloned the repo sync up the git submodules:

```
git submodule init
git submodule update
```
### Prerequisites

#### Ubuntu
```
wget -qO - http://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-bionic.list http://packages.lunarg.com/vulkan/lunarg-vulkan-bionic.list
sudo apt update
sudo apt install vulkan-sdk
```

#### Windows

1. Install [cmake](https://cmake.org/download/)
2. Install MinGW (posix 8.1.0) *or* MSVC
3. Install [Vulkan](https://vulkan.lunarg.com/sdk/home) 

#### MacOS

1. Install xcode CLI tools
```
xcode-select --install
```
2. Install Brew 
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```
3. Install cmake
```
brew install cmake
```
4. Install [Vulkan](https://vulkan.lunarg.com/sdk/home) 

### Build Julia Locally 

#### Prerequisites

1. Install [Julia](https://julialang.org/downloads/oldreleases/) v1.3.1 at least

2. In a Julia REPL in pkg mode (`]` at the REPL) you add  `CxxWrap` v0.11.0 at least
```julia
pkg> add CxxWrap
```
For more information about CxxWrap you can check [here](https://github.com/JuliaInterop/CxxWrap.jl).

Note that CxxWrap v0.10 and later depends on the `libcxxwrap_julia_jll` [JLL package](https://julialang.org/blog/2019/11/artifacts/) to manage the `libcxxwrap-julia` binaries.

3. Once you get `CxxWrap` installed you need to build the `libcxxwrap-julia` binaries. See the [libcxxwrap-julia Readme](https://github.com/JuliaInterop/libcxxwrap-julia) for information on how to build this library yourself and force CxxWrap to use your own version.

4. Once you have built `libcxxwrap-julia` in pkg mode (`]` in the REPL) you need to do
```julia
pkg> build CxxWrap
```
Then close and restart your REPL.

5. In pkg mode (`]` at the REPL) you add `Makie` v0.10.0 at least
```julia
pkg> add Makie
```

Note: If you get troubles to install those look at the [Julia locally troubles](#troubles-building-julia-locally) section.

#### Linux building

```
cmake . -DCMAKE_BUILD_TYPE={Debug|Release} -DBUILD_JULIA=ON -DJulia_EXECUTABLE="path/to/your/julia.exe" -DJlCxx_DIR="path/to/your/libcxxwrap/build"
cmake --build .
```
Artifacts can then be found in {Debug|Release}/bin

Note: The build of `libcxxwrap-julia` binaries should be the same than the build type you want to do here

#### Windows building (with Microsoft Visual Studio 2019)

1. Open the project with Microsoft Visual Studio 2019
2. From the built-in CMake support, see the [Visual docs](https://docs.microsoft.com/en-us/cpp/build/customize-cmake-settings?view=vs-2019) for more infos, you can choose your build option (mainly Release and the msvc_x64_x64 Toolset or Debug and the msvc_x64_x64 Toolset) and in the CMake command arguments field you can add : `-DBUILD_JULIA=ON`. Think to change to your new configuration in the upper window, click on the arrow with the default `x64-Debug`and choose your new configuartion. Save.
3. Still with the built-in CMake support you can configure the `Julia_Prefix` (which you set to "path/to/your/julia.exe") and `JlCxx_DIR`(which you set to "path/to/libcxxwrap-julia/out/build/build_type") option.
4. Save your settings, and right-click on the CMakeList.txt file and choose build

#### MacOS

Work In Progress

## Linked the outcoming binaries to this REPL

Now that you have build the library, you can clone this repo and go to the `src\Griddly.jl` file.

Once there you have to change the following line:
```julia
@wrapmodule(joinpath(@__DIR__,"..","..","Release","bin","JuGriddly"),:define_module_jugriddly)
```
and to replace the first argument to the path of the ibrary you build previously.

## Activate the Griddly Package

1. In the shell mode (hit `;` at the REPL)
```julia
shell> cd path/to/the/Griddly.jl/folder
```
2. In pkg mode (hit `]` at the REPL)
```julia
pkg> activate 
```
You should see ```(Griddly)pkg>``` in the REPL. From now on you can do ```using Griddly```

3. In the shell mode (hit `;` at the REPL)
```julia
shell> cd path/to/your/working/dir
```
You are now back to the main directory

4. Launch a test file, in the REPL:
```julia
include("path/to/Griddly.jl/test/play_gvgai_raw.jl")
```

5. If you want to quit the pkg mode with Griddly, just do in the pkg mode
```julia
(Griddly)pkg> activate
```
Which should now look like:
```julia
(v.1.3)pkg>
```

## Building docs

I hope to soon have a deployed documentation but it will have to wait a little bit.
In the meantime, if you want a proper doc because test are not enough you can:

```julia
shell> cd path/to/Griddly.jl

julia> include("docs/make.jl")

julia> using LiveServer

julia> serve(dir="docs/build")
```
Now you can enjoy a clearer documentation
