macro newjudgement(name, type, check = x -> nothing)
    inner = quote
            struct $name{T <: $type} <: AbstractJudgement{T}
            rating::T
            certainty::Float64
            location::Union{String, Missing}
            function $name{T}(r, c, l) where T
                $check(r)
                Taxonomy.check_certainty(c)
                new{T}(r, c, l)
            end
        end
    end
    outer = :($name(r::T, c = 1.0, l = missing) where T = $name{T}(r, c, l))
    return quote
        $(esc(inner))
        $(esc(outer))
    end
end

for (name, type) in zip((:JudgementBool, :JudgementNumber, :JudgementInt, :JudgementFloat, :JudgementString), (:Bool, :Number, :Int, :Real, :AbstractString))
    @eval begin
        @newjudgement($name, $type)
        @doc """
        $($name)

        A judgement type that only allows `$($type)` for its rating.
        """ $name
    end
end

const langcodes = ["aa" "ab" "ae" "af" "ak" "am" "an" "ar" "as" "av" "ay" "az" "ba" "be" "bg" "bi" "bm" "bn" "bo" "br" "bs" "ca" "ce" "ch" "co" "cr" "cs" "cu" "cv" "cy" "da" "de" "dv" "dz" "ee" "el" "en" "eo" "es" "et" "eu" "fa" "ff" "fi" "fj" "fo" "fr" "fy" "ga" "gd" "gl" "gn" "gu" "gv" "ha" "he" "hi" "ho" "hr" "ht" "hu" "hy" "hz" "ia" "id" "ie" "ig" "ii" "ik" "io" "is" "it" "iu" "ja" "jv" "ka" "kg" "ki" "kj" "kk" "kl" "km" "kn" "ko" "kr" "ks" "ku" "kv" "kw" "ky" "la" "lb" "lg" "li" "ln" "lo" "lt" "lu" "lv" "mg" "mh" "mi" "mk" "ml" "mn" "mr" "ms" "mt" "my" "na" "nb" "nd" "ne" "ng" "nl" "nn" "no" "nr" "nv" "ny" "oc" "oj" "om" "or" "os" "pa" "pi" "pl" "ps" "pt" "qu" "rm" "rn" "ro" "ru" "rw" "sa" "sc" "sd" "se" "sg" "si" "sk" "sl" "sm" "sn" "so" "sq" "sr" "ss" "st" "su" "sv" "sw" "ta" "te" "tg" "th" "ti" "tk" "tl" "tn" "to" "tr" "ts" "tt" "tw" "ty" "ug" "uk" "ur" "uz" "ve" "vi" "vo" "wa" "wo" "xh" "yi" "yo" "za" "zh" "zu"]

@eval begin
    @newjudgement(JudgementLanguage, AbstractString, x -> x in langcodes ? nothing : throw(ArgumentError("Not an ISO 639-1 code")))
    @doc """
    JudgementLanguage

    A judgement type that only allows ISO 639-1 langcodescode.
    """ JudgementLanguage
end
