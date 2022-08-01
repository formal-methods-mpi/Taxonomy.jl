struct LGCM <: Taxon
    timecoding::Judgement
    ntimepoints::Judgement
    npredictors::Judgement
    nonlinearfunction::Judgement
end

function length_time(timecoding::Vector{<:Number}) length(timecoding) end
length_time([1,2])

function LGCM(; timecoding, 
    ntimepoints = length_time(timecoding),
    npredictors = 0,
    nonlinearfunction = 0)
    LGCM(timecoding, 
        ntimepoints, 
        npredictors, 
        nonlinearfunction
        )
end