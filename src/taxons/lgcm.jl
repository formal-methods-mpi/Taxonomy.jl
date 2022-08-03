struct LGCM <: Taxon
    timecoding::Judgement{ <: Union{ <: AbstractArray{ <: Number}, Missing}}
    ntimepoints::Judgement{ <: Union{ <: Int, Missing}}
    npredictors::Judgement{ <: Union{ <: Int, Missing}}
    nonlinearfunction::Judgement{ <: Union{ <: Int, Missing}}
    LGCM(timecoding, ntimepoints, npredictors, nonlinearfunction) =
        new(J(timecoding), J(ntimepoints), J(npredictors), J(nonlinearfunction))
end

function LGCM(; 
    timecoding = NoJudgement(), 
    ntimepoints = NoJudgement(),
    npredictors = 0,
    nonlinearfunction = 0)
    if !ismissing(rating(timecoding))
        implied_ntimepoints = length(rating(timecoding))
        if ismissing(rating(ntimepoints))
            ntimepoints = implied_ntimepoints
        end
        if ntimepoints != implied_ntimepoints
            throw(ArgumentError("ntimepoints does not aggree with ntimepoints"))
        end
    end
    
    LGCM(timecoding, 
        ntimepoints, 
        npredictors, 
        nonlinearfunction
        )
end

