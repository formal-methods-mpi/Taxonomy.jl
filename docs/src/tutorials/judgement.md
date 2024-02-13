`Judgment`s are an integral part of Taxonomy.
They represent whatever you want to code about a [`Record`](@ref).
More specifically, a `Judgement` might be about the [`Record`](@ref), a [`Study`](@ref) within a [`Record`](@ref), or about a [`Model`](@ref) is thought to be composed from Studies, 
To define a judgment you must supply a name, on which [`JudgementLevel`](@ref) it is (`Study`, `Record`, `Model`), some documentation (i.e., what it is you want to code), and optionally, type constrains, a function to check the validity (e.g., N can not be smaller than zero), and if the judgement can only be made once.

```jldoctest; output = false
using Taxonomy
using Taxonomy.Judgements
## We can also do specific input checks, e.g. if we want to check if the input has a predefined value:
@newjudgement(
    Access,
    RecordJudgement,
    """
    A judgement type that codes how accessable a paper is.
    """,
    AbstractString,
    x -> x in ["open", "closed", "none"] ? nothing : throw(ArgumentError("Not an agreed upon value."))
)
Access("open")
Access("not open")

# output

ERROR: ArgumentError: Not an agreed upon value.

```

By default, [`Judments`](@ref) are assumed to be unique, i.e., there can only be one.
If specified more than once, such a Judgement will throw an error.
Judgements with `unique = false` are gathered into a vector.