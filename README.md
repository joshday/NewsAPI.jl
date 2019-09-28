[![Build Status](https://travis-ci.org/joshday/NewsAPI.jl.svg?branch=master)](https://travis-ci.org/joshday/NewsAPI.jl)

# NewsAPI

Powered by [NewsAPI.org](https://newsapi.org)

## First:

Add `ENV["NEWS_API_KEY"] = <key>` to `~/.julia/config/startup.jl`

## Then:

```julia
using NewsAPI, Dates, HTTP

NewsAPI.sources()

NewsAPI.everything(q="bitcoin", from=today() - Day(1))

NewsAPI.topheadlines(country="us")
```