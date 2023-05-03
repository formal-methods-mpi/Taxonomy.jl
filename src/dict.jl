# create a dictionary for Records()

# Create a custom RecordDatabase type

struct RecordDatabase
    records::Dict{UUID, Record}
end

# Constructor to create an empty RecordDatabase
RecordDatabase() = RecordDatabase(Dict{UUID, Record}())

# Overload the push! function to add a new Record to the RecordDatabase
# builds function to be able to push new records to the database
# push! as function with two arguments: db of type RecordDatabase and record of type Record, returns an instance of RecordDatabase
function Base.push!(db::RecordDatabase, record::Record) 
    key = record.id # Use the Record's id as the key
    db.records[key] = record # Add the Record to the database
    return db
end