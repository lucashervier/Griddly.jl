using Griddly
using Makie
using Documenter: deploydocs, makedocs

makedocs(sitename = "Griddly.jl", modules = [Griddly], doctest = false,
pages = [
        "Home" => "index.md",
        "Library Outline" => Any[
            "Observer" => "lib/observer.md",
            "Grid" => "lib/grid.md",
            "Game Process" => "lib/game_process.md",
            "Player" => "lib/player.md",
            "Render Tools" => "lib/render_tool.md",
            "Utils" => "lib/utils.md",
        ],
        "Examples" => Any[
            "Minidroggo" => "examples/minidroggo.md",
            "Sokoban" => "examples/sokoban.md",
            "Multi Player" => "examples/multiplayer.md"
        ],
    ])
deploydocs(repo = "github.com/luhervier/Griddly.jl.git")
