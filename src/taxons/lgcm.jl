struct LGCM <: Taxon
    timecoding::Judgement
    ntimepoints::Judgement
    npredictors::Judgement
    nonlinearfunction::Judgement
end

function LGCM(; 
    timecoding = NoJudgement(), 
    ntimepoints = NoJudgement(),
    npredictors = 0,
    nonlinearfunction = 0)

    implied_ntimepoints = length(rating(timecoding))
    if ismissing(rating(ntimepoints))
        ntimepoints = implied_ntimepoints
    end
    if !ismissing(rating(timecoding)) && ntimepoints != implied_ntimepoints
        throw(DomainError("ntimepoints does not aggree with ntimepoints"))
    end
    LGCM(timecoding, 
        ntimepoints, 
        npredictors, 
        nonlinearfunction
        )
end

