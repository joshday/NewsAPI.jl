using NewsAPI
using Test
using Dates

@testset "NewsAPI.jl" begin
    e = NewsAPI.Everything(q="bitcoin", from=now() - Day(1))
end
