# create a dictionary for Records()

# Create a custom RecordDatabase type
struct RecordDatabase
    records::Dict{String, Record}
end

# Constructor to create an empty RecordDatabase
RecordDatabase() = RecordDatabase(Dict{String, Record}())

# Overload the push! function to add a new Record to the RecordDatabase
# builds function to be able to push new records to the database
# push! as function with two arguments: db of type RecordDatabase and record of type Record, returns an instance of RecordDatabase
function Base.push!(db::RecordDatabase, record::Record) 
    key = string(record.id) # Use the Record's id as the key
    db.records[key] = record # Add the Record to the database
    return db
end

# Create a new RecordDatabase instance
my_database = RecordDatabase()

# Test:
# Create Record instances, this is not working yet
r1 = Record(rater="A", id="1234")
r2 = Record(rater="B", id="4567")

# Add the Record instances to the RecordDatabase
push!(my_database, r1)
push!(my_database, r2)

# Iterate through the records in the RecordDatabase
for (key, record) in database.records
    println("$key: $(record.rater)")
end