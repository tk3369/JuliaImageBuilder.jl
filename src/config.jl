CONFIGS = [
    # JuliaFormatter.jl
    SysImageConfig("julia-formatter", [Dependency(:JuliaFormatter, nothing)]),

    # Plots.jl
    SysImageConfig(
        "julia-plots",
        [Dependency(:Plots, "deps/SnoopCompile/precompile_script.jl")],
    ),
]
