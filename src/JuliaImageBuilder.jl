module JuliaImageBuilder

export build

using Pkg
using PackageCompiler

include("type.jl")
include("config.jl")
include("builder.jl")

end
