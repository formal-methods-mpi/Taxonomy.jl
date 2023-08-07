for (name, type) in zip((:JudgementBool, :JudgementNumber, :JudgementInt, :JudgementFloat, :JudgementString),
    (:Bool, :Number, :Int, :Real, :AbstractString))

    @eval begin
        @doc """
        $($name)

        A judgement type that only allows `$($type)` for its rating.
        """
        struct $name{T <: $type} <: AbstractJudgement{T}
            rating::T
            certainty::Float64
            location::Union{String, Missing}
            function $name{T}(r, c, l) where T
                Taxonomy.check_certainty(c)
                new{T}(r, c, l)
            end
        end
    end
    @eval $name(r::T, c = 1.0, l = missing) where T = $name{T}(r, c, l)
end
