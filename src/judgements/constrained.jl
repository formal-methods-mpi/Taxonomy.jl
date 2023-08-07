for (name, type) in zip((:JBool, :JNumber, :JInt, :JFloat, :JString), (:(Base.Bool), :(Base.Number), :(Base.Int), :(Base.Real), :(Base.AbstractString)))
    @eval begin
        @newjudgement($name, $type)
        @doc """
        $($name)

        A judgement type that only allows `$($type)` for its rating.
        """ $name
    end
end
