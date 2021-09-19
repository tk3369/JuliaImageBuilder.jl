using JuliaFormatter

format_text("""

module X

struct Foo
    x::Int
end

function foo(x::Foo)
    return nothing
end

bar() = foo(Foo(1))
bar(f::Foo) = foo(f)

end

""")
