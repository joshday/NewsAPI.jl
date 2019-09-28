using NewsAPI
using Test
using Dates

@testset "NewsAPI.jl" begin
    @test length(NewsAPI.sources()) > 0
    @test length(NewsAPI.everything(q="bitcoin", from=today() - Day(1))) > 0
    @test length(NewsAPI.topheadlines(country="us")) > 0
end