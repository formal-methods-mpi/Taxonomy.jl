abstract type AbstractLocation end
abstract type AbstractDOI <: AbstractLocation end
abstract type AbstractMeta end
struct PaperRecord
    location::AbstractLocation
    meta::AbstractMeta
end