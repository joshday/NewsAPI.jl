# NewsAPI


## Usage

- First:

Add `ENV["NEWS_API_KEY"] = <key>` to `~/julia/config/startup.jl`


### Everything

Reference: https://newsapi.org/docs/endpoints/everything

```julia
using NewsAPI, Dates, HTTP

NewsAPI.sources()

NewsAPI.everything(q="bitcoin", from=today() - Day(1))

NewsAPI.topheadlines(country="us")
```