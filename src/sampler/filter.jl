function Base.filter(f, s::Vector{Union{JudgementLevel,AbstractJudgement}})::Vector{Union{JudgementLevel,AbstractJudgement}}
    res_vec = []
    for i in 1:length(s)
        if f(s[i])
            res_vec = push!(res_vec, s[i])
        end
    end

    return res_vec
end
