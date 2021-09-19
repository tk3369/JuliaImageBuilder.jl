struct Dependency
    package::Symbol
    precompile_file::Union{String,Nothing}
end

struct SysImageConfig
    name::String
    dependencies::Vector{Dependency}
end
