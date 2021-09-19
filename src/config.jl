CONFIGS = [
    SysImageConfig("julia-formatter", [Dependency(:JuliaFormatter, nothing)]),
    SysImageConfig(
        "julia-plot",
        [Dependency(:Plots, "deps/SnoopCompile/precompile_script.jl")],
    ),
]
