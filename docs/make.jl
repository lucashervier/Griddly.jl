using Griddly
using Documenter: deploydocs, makedocs

makedocs(sitename = "Griddly.jl", modules = [Griddly], doctest = false)
deploydocs(repo = "github.com/luhervier/Griddly.jl.git")
