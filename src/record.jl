struct Record
    location::AbstractLocation
    meta::AbstractMeta
    taxons::Vector{<: Taxon}
    spec::Judgement
    data::Judgement
end
function Record(;location, meta = missing, taxons, spec, data)
    if ismissing(meta)
        meta = MetaData(location)
    end
    Record(location, meta, taxons, spec, data)
end
