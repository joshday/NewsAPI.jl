[![CI](https://github.com/joshday/NewsAPI.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/joshday/NewsAPI.jl/actions/workflows/CI.yml)
[![Docs Build](https://github.com/joshday/NewsAPI.jl/actions/workflows/Docs.yml/badge.svg)](https://github.com/joshday/NewsAPI.jl/actions/workflows/Docs.yml)
[![Stable Docs](https://img.shields.io/badge/docs-stable-blue)](https://joshday.github.io/NewsAPI.jl/stable/)
[![Dev Docs](https://img.shields.io/badge/docs-dev-blue)](https://joshday.github.io/NewsAPI.jl/dev/)

# NewsAPI

Powered by [NewsAPI.org](https://newsapi.org)

## First:

Add `ENV["NEWS_API_KEY"] = <key>` to `~/.julia/config/startup.jl`

## Then:

```julia
using NewsAPI, Dates

s = NewsAPI.sources()

e = NewsAPI.everything(q="bitcoin", from=today() - Day(1))

h = NewsAPI.topheadlines(country="us")

# Returned objects satisfy the Tables.jl interface
using DataFrames

DataFrame(s)
DataFrame(e)
DataFrame(h)
```
