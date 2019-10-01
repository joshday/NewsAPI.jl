module NewsAPI

import HTTP
using Dates
using Parameters
using JSON3

function __init__()
    if !haskey(ENV, "NEWS_API_KEY")
        @warn "This package isn't usable without ENV[\"NEWS_API_KEY\"] defined."
        @info "Visit https://newsapi.org to get an API key."
    end
end

const auth_header = HTTP.Header["authorization" => ENV["NEWS_API_KEY"]]

abstract type AbstractQuery end

function add_params(query::String, aq::T; verbose=true) where {T <: AbstractQuery}
    for field in fieldnames(T)
        item = getfield(aq, field)
        !isnothing(item) && (query *= "$field=$item&")
    end
    query = rstrip(query, '&')
    query = replace(query, ' ' => "%20")
    query = replace(query, "'" => "%27")
    verbose && @info "Full query:" query
    return query
end

function Base.show(io::IO, q::T) where {T <: AbstractQuery}
    println(io, T)
    for field in fieldnames(T)
        item = getfield(q, field)
        !isnothing(item) && println("  > $field:   $item")
    end
end


#-----------------------------------------------------------------------# Sources
@with_kw_noshow struct Sources <: AbstractQuery
    category    = nothing
    language    = nothing
    country     = nothing
end

function HTTP.get(s::Sources; verbose=true)
    query = add_params("https://newsapi.org/v2/sources?", s)
    JSON3.read(HTTP.get(query, headers=auth_header).body).sources
end

"""
    sources(; category=nothing, language=nothing, country=nothing, verbose=true)

Reference: https://newsapi.org/docs/endpoints/sources
"""
sources(;verbose=true, kw...) = HTTP.get(Sources(;kw...); verbose=verbose)

#-----------------------------------------------------------------------# TopHeadlines
@with_kw_noshow struct TopHeadlines <: AbstractQuery
    country     = nothing
    category    = nothing
    sources     = nothing
    q           = nothing
    pageSize    = nothing
    page        = nothing
end

function HTTP.get(th::TopHeadlines; verbose=true)
    query = add_params("https://newsapi.org/v2/top-headlines?", th; verbose=verbose)
    return JSON3.read(HTTP.get(query, headers=auth_header).body).articles
end

"""
    topheadlines(; country, category, sources, q, pageSize, page)

Reference: https://newsapi.org/docs/endpoints/top-headlines
"""
topheadlines(;verbose=true, kw...) = HTTP.get(TopHeadlines(; kw...), verbose=verbose)

#-----------------------------------------------------------------------# Everything
@with_kw_noshow struct Everything <: AbstractQuery
    q               = nothing
    qInTitle        = nothing
    sources         = nothing
    domains         = nothing
    excludeDomains  = nothing
    from            = nothing
    to              = nothing
    language        = nothing
    sortBy          = nothing
    pageSize        = nothing
    page            = nothing
end

function HTTP.get(e::Everything; verbose=true)
    query = add_params("https://newsapi.org/v2/everything?", e; verbose=verbose)
    return JSON3.read(HTTP.get(query, headers=auth_header).body).articles
end

"""
    everything(q, qInTitle, sources, domains, excludeDomains, from, to, language,
               sortBy, pageSize, page)

Reference: https://newsapi.org/docs/endpoints/everything
"""
everything(;verbose=true, kw...) = HTTP.get(Everything(;kw...); verbose=verbose)

end # module
