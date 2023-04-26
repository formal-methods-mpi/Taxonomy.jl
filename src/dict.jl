# create a dictionary for Records()

# Create a custom RecordDatabase type
struct RecordDatabase
    records::Dict{String, Record}
end
# this is a dictionary with a string key and a Record value (a dictionary of records)

# Constructor to create an empty RecordDatabase
RecordDatabase() = RecordDatabase(Dict{String, Record}())

# Overload the push! function to add a new Record to the RecordDatabase
# builds function to be able to push new records to the database
function Base.push!(db::RecordDatabase, record::Record)
    key = string(record.id) # Use the Record's id as the key
    db.records[key] = record 
    return db
end

# Create a new RecordDatabase instance
database = RecordDatabase()

# Create Record instances
r1 = Record("A", Base.UUID("c5a62e32-eedd-4b1f-9c7b-c6a341c1e2b8"), AbstractLocation(), AbstractMeta(), Vector{Taxon}(), Judgement(), Judgement())
r2 = Record("B", Base.UUID("1a6a9e6b-e3f3-4d2b-a6ba-af659a02a6a1"), AbstractLocation(), AbstractMeta(), Vector{Taxon}(), Judgement(), Judgement())
# UUID is a unique identifier for each record

# Add the Record instances to the RecordDatabase
push!(database, r1)
push!(database, r2)

# Iterate through the records in the RecordDatabase
for (key, record) in database.records
    println("$key: $(record.rater)")
end