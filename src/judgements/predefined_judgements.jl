
"""
    CFI()

Judgement for Comparative Fit Index (CFI). 
"""

@newjudgement(
    CFI,
    ModelJudgement,
    """
    The Taxons Comparative Fit Index (CFI). Takes float values or missings. 
    """,
    Float64 # Input type. In this case Integer. 
)


@newjudgement(
    Empirical, # Name of this custom judgement type
    StudyJudgement, # Specify on which level this judgement should be used. Paper level in this case. 
    ## Here we can add a documentation, that is then availible with ?Empirical:
    """
    The paper is empirical. Takes boolian values or missings. 
    """,
    Bool # Input type. In this case boolian.
)

"""
    Lang()

Language Judgement.
"""

const langcodes = ["aa" "ab" "ae" "af" "ak" "am" "an" "ar" "as" "av" "ay" "az" "ba" "be" "bg" "bi" "bm" "bn" "bo" "br" "bs" "ca" "ce" "ch" "co" "cr" "cs" "cu" "cv" "cy" "da" "de" "dv" "dz" "ee" "el" "en" "eo" "es" "et" "eu" "fa" "ff" "fi" "fj" "fo" "fr" "fy" "ga" "gd" "gl" "gn" "gu" "gv" "ha" "he" "hi" "ho" "hr" "ht" "hu" "hy" "hz" "ia" "id" "ie" "ig" "ii" "ik" "io" "is" "it" "iu" "ja" "jv" "ka" "kg" "ki" "kj" "kk" "kl" "km" "kn" "ko" "kr" "ks" "ku" "kv" "kw" "ky" "la" "lb" "lg" "li" "ln" "lo" "lt" "lu" "lv" "mg" "mh" "mi" "mk" "ml" "mn" "mr" "ms" "mt" "my" "na" "nb" "nd" "ne" "ng" "nl" "nn" "no" "nr" "nv" "ny" "oc" "oj" "om" "or" "os" "pa" "pi" "pl" "ps" "pt" "qu" "rm" "rn" "ro" "ru" "rw" "sa" "sc" "sd" "se" "sg" "si" "sk" "sl" "sm" "sn" "so" "sq" "sr" "ss" "st" "su" "sv" "sw" "ta" "te" "tg" "th" "ti" "tk" "tl" "tn" "to" "tr" "ts" "tt" "tw" "ty" "ug" "uk" "ur" "uz" "ve" "vi" "vo" "wa" "wo" "xh" "yi" "yo" "za" "zh" "zu"]

@newjudgement(
    Lang,
    RecordJudgement,
    """
    A judgement type that only allows ISO 639-1 language codes.
    """,
    AbstractString,
    x -> x in langcodes ? nothing : throw(ArgumentError("Not an ISO 639-1 code"))
)



"""
    N()

Judgement for N. 
"""

@newjudgement(
    N,
    StudyJudgement, # Specify on which level this judgement should be used. Study level in this case.  
    """
    The number of observations in the study. Takes integer values or missings. 
    """,
    Int # Input type. In this case Integer. 
)

@newjudgement(
    Standardized,
    ModelJudgement,  
    """
    Any part of the data or model is standardized

    Procedure:
    * Search for standard*
    * If present, give True
    """,
    Bool # Input type. In this case boolean.
)

@newjudgement(
    Quest,
    ModelJudgement,
    """
    What questionnaire was used to measure the latent variable.
    
    Procedure:
    * Look for first instance of questionnaire, 
    * acronym or name is fine, copy and paste citation if availible
    * Do not bother whether the scale is translated, modified or shortened.
    * spend little time (<30s) on searching for it
    * should be given multiple times for all quests present in a model.

    """,
    AbstractString,
    x -> nothing,
    unique = false
)