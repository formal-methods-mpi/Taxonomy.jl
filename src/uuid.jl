# base UUID is the one from Taxonomy.jl
tethered_id(string, tether = UUIDs.UUID("fea09e6a-dc4a-42ec-a35f-5cfade855812")) = UUIDs.uuid5(tether, string)

"""
Generate an Entry ID

To create links between entries we need a stable reference point.
This ID is generated initially from `url(location)` and if the url is missing, it is generated randomly.
After the ID is generated once, it is saved with the [`Record`](@ref) and should not be changed.
"""
generate_id() = UUIDs.uuid4()
generate_id(loc::String) = tethered_id(loc)
generate_id(loc::AbstractLocation) = ismissing(url(loc)) ? generate_id() : tethered_id(url(loc))
