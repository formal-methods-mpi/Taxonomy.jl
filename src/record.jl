using Taxonomy
struct Record <: JudgementLevel
    rater::Union{AbstractString, Missing}
    id::Union{Base.UUID, Missing}
    location::AbstractLocation
    meta::AbstractMeta
    judgements::Union{Dict{Symbol, Vector{Union{AbstractJudgement, Study}}}, Missing}
end

function Record(rater, id::String, location, meta, judgements)
    Record(rater, Base.UUID(id), location, meta, judgements)
end

function Record(j...; rater = missing, id = missing, location = missing, meta = missing)
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

    check_judgement_level.(j, (RecordJudgement(), ))
    
    judgements = judgement_dict(j...)
    Record(rater, id, location, meta, judgements)
end


id(x::Record) = x.id        
rater(x::Record) = x.rater
MetaData(x::Record) = x.meta
location(x::Record) = x.location

Base.length(::Record) = 1

ExtractStudy(x::Record) = judgements(x)[:Study]