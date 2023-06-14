function print_type_name(io::IO, struct_instance)
    print(io, nameof(typeof(struct_instance))); print(io, "\n")
end

function print_field_types(io::IO, struct_instance)
    fields = fieldnames(typeof(struct_instance))
    types = [typeof(getproperty(struct_instance, field)) for field in fields]
    field_types = string.(fields).*": ".*string.(types)
    field_types = "   ".*string.(field_types).*("\n")
    print(io, field_types...)
end

function Base.show(io::IO, struct_inst::Record)
    print_type_name(io, struct_inst)
    print_field_types(io, struct_inst)
end

function Base.show(io::IO, struct_inst::AbstractMeta)
    print_type_name(io, struct_inst)
    print_field_types(io, struct_inst)
end

function Base.show(io::IO, struct_inst::Taxon)
    print_type_name(io, struct_inst)
    print_field_types(io, struct_inst)
end

function Base.show(io::IO, x::NoTaxonYet)
    if ismissing(x.modeltype)
        print(io, "NoTaxonYet(\"", x.accessdate, "\")")
    else
        print(io,
        "NoTaxonYet(accessdate = \"",
        x.accessdate,
        "\", modeltype = \"",
        x.modeltype,
        "\")")
    end
end
