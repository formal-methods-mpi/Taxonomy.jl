struct LGCM <: Taxon
    timecoding::Judgement
    ntimepoints::Judgement
    npredictors::Judgement
    nonlinearfunction::Judgement
end

function LGCM(; 
    timecoding, 
    ntimepoints =  
    if isa(timecoding, Union{Vector{<:Number}, UnitRange{<:Number}})
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

