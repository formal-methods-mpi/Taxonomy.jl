doi(x::Record) = x.location.doi
function doi(x::RecordDatabase) 
  dois = []
     for i in keys(x)
         push!(dois, location(get(x.records, i, false)).doi)
     end
  return dois
end

@deprecate doi(x) url(x)

function check_doi(x::RecordDatabase, y::Record)
    doi_y = doi(y)
    if doi_y in doi(x)
        throw(ArgumentError("The DOI $doi_y is already in the data base."))
    end
end
function check_doi(x::RecordDatabase, y::RecordDatabase)
    dois_x = doi(x)
    dois_y = doi(y)

    duplicated_dois = intersect(dois_x, dois_y)

    if length(duplicated_dois) > 0
        duplicated_dois_str = join(duplicated_dois)
        throw(ArgumentError("Duplicated DOI(s): $duplicated_dois_str"))
    end
end
check_doi(x::RecordDatabase, y::Pair) = check_doi(x,y.second)

@deprecate check_doi(x, y) check_url(x, y)
