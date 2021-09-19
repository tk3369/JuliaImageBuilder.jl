# JuliaImageBuilder

This is a convenient package for building Julia system images using PackageCompiler.jl.

# How to use?

```julia
using JuliaImageBuilder
build("julia-formatter")
build("julia-plot")
```

System images are saved at `~/.julia/images/[julia-version]` directory.

# Contribution
Common image recipes are defined at src/config.jl.
Please submit pull requests to add new image configurations.

