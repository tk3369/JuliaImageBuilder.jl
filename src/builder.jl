function ensure_package_compiler()
    Pkg.activate()  # root environment
    Pkg.add("PackageCompiler")
    return nothing
end

function output_dir()
    dir = joinpath(DEPOT_PATH[1], "images", string(VERSION))
    if !isdir(dir)
        mkpath(dir) || error("Unable to create output directory: $dir")
    end
    return dir
end

function activate_build_directory(c::SysImageConfig)
    build_dir = mktempdir()
    packages = string.(getproperty.(c.dependencies, :package))
    Pkg.activate(build_dir)
    Pkg.add.(packages)
    return build_dir
end

function load_dependencies(c::SysImageConfig)
    for dep in c.dependencies
        @eval import $(dep.package)
    end
end

function Base.pathof(dep::Dependency)
    return pathof(eval(dep.package))
end

function deactivate_build_directory()
    Pkg.activate()
end

function find_precompile_files(c::SysImageConfig)
    files = String[]

    # get pacakge-provided precompile files
    for pkg in c.dependencies
        if pkg.precompile_file !== nothing
            push!(files, pathof(pkg) * "../../../" * pkg.precompile_file)
        end
    end

    # add custom precompile files
    custom_dir = joinpath(@__DIR__, "../precompile/$(c.name)")
    if isdir(custom_dir)
        append!(files, readdir(custom_dir; join = true))
    end
    return files
end

function make_sysimage(
    c::SysImageConfig,
    output_file::String,
    precompile_files::Vector{<:AbstractString},
)
    modules = [dep.package for dep in c.dependencies]
    return create_sysimage(
        modules,
        sysimage_path = output_file,
        precompile_execution_file = precompile_files,
    )
end

function build(c::SysImageConfig)
    output_file = joinpath(output_dir(), "$(c.name).so")
    try
        activate_build_directory(c)
        load_dependencies(c)
        precompile_files = find_precompile_files(c)
        @info "files" precompile_files
        return make_sysimage(c, output_file, precompile_files)
    finally
        # deactivate_build_directory()
    end
end

function build(image_name::String)
    idx = findfirst(c -> c.name == image_name, CONFIGS)
    if idx !== nothing
        build(CONFIGS[idx])
    else
        println("ERROR: image config not found for `$image_name`")
        println("Please use one of the following supported images:")
        foreach(c -> println("  ", c.name), CONFIGS)
    end
end
