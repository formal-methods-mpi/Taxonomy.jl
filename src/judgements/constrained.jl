base_types = [:Bool :Number :Int :String]
vec_types = @eval [:(Vector{<: Union{Missing, $x}}) for x in base_types]
types = [base_types vec_types]
names = Symbol.([("Judgement" .* String.(base_types)) ("JudgementVec" .* String.(base_types))])

for (name, type) in zip(names, types)
        @eval begin
        export $name
        @newjudgement(
            $name,
            AnyLevelJudgement,
            """
            A generic judgement that only allows ratings of a certain type.
            """,
            $type)
    end
end
