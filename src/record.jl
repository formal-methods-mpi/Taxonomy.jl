struct Record
    id::Union{Base.UUID, Missing}
    location::AbstractLocation
    meta::AbstractMeta
    taxons::Union{Vector{<: Taxon}, Missing}
    spec::Union{Judgement, Missing}
    data::Union{Judgement, Missing}
end
function Record(id::String, location, meta, taxons, spec, data)
    Record(Base.UUID(id), location, meta, taxons, spec, data)
end
function Record(;id = missing, location = missing, meta = missing, taxons = missing, spec = missing, data = missing)
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
    Record(id, location, meta, taxons, spec, data)
end

taxons(x::Record) = x.taxons
MetaData(x::Record) = x.meta
location(x::Record) = x.location
spec(x::Record) = x.spec
data(x::Record) = x.data
