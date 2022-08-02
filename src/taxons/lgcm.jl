struct LGCM <: Taxon
    timecoding::Judgement{Union{AbstractArray{Number}, Missing}}
    ntimepoints::Judgement{Union{Int, Missing}}
    npredictors::Judgement{Union{Int, Missing}}
    nonlinearfunction::Judgement{Union{Int, Missing}}
end

function LGCM(; 
    timecoding, 
    ntimepoints =  
    if isa(timecoding, Vector{<:Number})
        length(timecoding)
    elseif ismissing(timecoding)
        missing
    else
        throw(DomainError(timecoding, "please provide a numeric vector or missing for timecoding argument"))
    end,
    npredictors = 0,
    nonlinearfunction = 0)
    LGCM(timecoding, 
        ntimepoints, 
        npredictors, 
        nonlinearfunction
        )
end

