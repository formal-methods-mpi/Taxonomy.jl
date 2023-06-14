struct Record
    rater::Union{AbstractString, Missing}
    id::Union{Base.UUID, Missing}
    location::AbstractLocation
    meta::AbstractMeta
    taxons::Union{Vector{<: Taxon}, Missing}
    spec::Union{Judgement, Missing}
    data::Union{Judgement, Missing}
end
function Record(rater, id::String, location, meta, taxons, spec, data)
    Record(rater, Base.UUID(id), location, meta, taxons, spec, data)
end

function Record(; rater = missing, id = missing, location = missing, meta = missing, taxons = missing, spec = missing, data = missing)
    if ismissing(rater)
        @warn "Please provide your rater ID. This should be your initials."
    end
    if ismissing(id)
        if isa(location, AbstractDOI)
            @warn "You really should supply an ID. May we suggest (from DOI): " * string(generate_id(location))
        else
            @warn "You really should supply an ID. May we suggest: " * string(generate_id())
        end
    end
    if ismissing(location)
        location = NoLocation()
        @warn "You really should supply a location."
    end
    meta_missing = ismissing(meta)
    if meta_missing
        meta = MetaData(location)
        if isa(meta, IncompleteMeta) && meta_missing
            @warn "Some of the metadata seem to be incomplete. Check again."
        end
    end
    if ismissing(taxons)
        @warn "`taxons` is missing. Maybe you mean `NoTaxon()`?"
    end
    if ismissing(spec)
        @warn "`spec` is missing. Maybe you mean `NoJudgment()`?"
    end
    if ismissing(data)
        @warn "`data` is missing. Maybe you mean `NoJudgment()`?"
    end
    Record(rater, id, location, meta, taxons, spec, data)
end

id(x::Record) = x.id        
rater(x::Record) = x.rater
taxons(x::Record) = x.taxons
MetaData(x::Record) = x.meta
location(x::Record) = x.location
spec(x::Record) = x.spec
data(x::Record) = x.data

Base.length(::Record) = 1
