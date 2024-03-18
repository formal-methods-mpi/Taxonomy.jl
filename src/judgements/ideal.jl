##---Setup Packages---
# all required dependencies, their version, and from where to install them should be committeed to Manifest.toml
#import Pkg; Pkg.instantiate()
using Taxonomy;
using Taxonomy.Judgements;
using StenoGraphs
struct Weight{N <: Number} <: EdgeModifier w::N end

##---Define what to Code---

## We now can define custom Judgements with specific input types and automatic plausibility checks.
## We can also define these Judgement types for different levels of the coding process: 
    # - Paper (called Record, in case we want to code something different than papers)
    # - Study (meaning a that something is relating to the same dataset)

# Basic approach -----------
# A judgment that is supposed to be used on a per paper level:
@newjudgement(
    Empirical, # Name of this custom judgement type
    RecordJudgement, # Specify on which level this judgement should be used. Paper level in this case. 
    ## Here we can add a documentation, that is then availible with ?Empirical:
    """
    The paper is empirical. Takes boolian values or missings. 
    """,
    Bool # Input type. In this case boolian.
)

# A judgment that is supposed to be used on a per study level:
@newjudgement(
    N,
    StudyJudgement, # Specify on which level this judgement should be used. Study level in this case.  
    """
    The number of observations in the study. Takes integer values or missings. 
    """,
    Int # Input type. In this case Integer. 
)

# Input checks -------------------------
## We can also define custom plausibility checks, that will be additional to the built-in type checks. 

## For example, we might be interested in testing, whether an input value lies within a certain range: 
@newjudgement(
    NModels,
    """
    The number of models that use the same dataset.
    """,
    StudyJudgement,
    Int,
    ## Here we define a certain range. If our Input value lies within that range, nothing happens. Otherwise, we get an error. 
    # x -> x^2 is the syntax to define an anyonym function
    # x < 3 : "Value if test left is true" : "value otherwise"
    x ->
        1 < x < 100 ? nothing :
        throw(ArgumentError("Very unlikely to observe that many models. NModels should lie between 1 and 100 models."))
)


## We can also do specific input checks, e.g. if we want to check if the input has a predefined value:
const langcodes =
    ["aa" "ab" "ae" "af" "ak" "am" "an" "ar" "as" "av" "ay" "az" "ba" "be" "bg" "bi" "bm" "bn" "bo" "br" "bs" "ca" "ce" "ch" "co" "cr" "cs" "cu" "cv" "cy" "da" "de" "dv" "dz" "ee" "el" "en" "eo" "es" "et" "eu" "fa" "ff" "fi" "fj" "fo" "fr" "fy" "ga" "gd" "gl" "gn" "gu" "gv" "ha" "he" "hi" "ho" "hr" "ht" "hu" "hy" "hz" "ia" "id" "ie" "ig" "ii" "ik" "io" "is" "it" "iu" "ja" "jv" "ka" "kg" "ki" "kj" "kk" "kl" "km" "kn" "ko" "kr" "ks" "ku" "kv" "kw" "ky" "la" "lb" "lg" "li" "ln" "lo" "lt" "lu" "lv" "mg" "mh" "mi" "mk" "ml" "mn" "mr" "ms" "mt" "my" "na" "nb" "nd" "ne" "ng" "nl" "nn" "no" "nr" "nv" "ny" "oc" "oj" "om" "or" "os" "pa" "pi" "pl" "ps" "pt" "qu" "rm" "rn" "ro" "ru" "rw" "sa" "sc" "sd" "se" "sg" "si" "sk" "sl" "sm" "sn" "so" "sq" "sr" "ss" "st" "su" "sv" "sw" "ta" "te" "tg" "th" "ti" "tk" "tl" "tn" "to" "tr" "ts" "tt" "tw" "ty" "ug" "uk" "ur" "uz" "ve" "vi" "vo" "wa" "wo" "xh" "yi" "yo" "za" "zh" "zu"]

@newjudgement(
    Lang,
    RecordJudgement,
    """
    A judgement type that only allows ISO 639-1 language codes.
    """,
    AbstractString,
    x -> x in langcodes ? nothing : throw(ArgumentError("Not an ISO 639-1 code"))
)

## If missings are valid types for the custom type check, we have to define that as well. If we don't provide a input check function, missings are always allowed per default. 
@newjudgement(
    Data,
    StudyJudgement,
    """
    Is the data for the study is availible? Valid values include: "openly", "closed" and "upon request".
    """,
    AbstractString,
    x ->
        (x in ["openly", "closed", "upon request"]) | ismissing(x) ? nothing :
        throw(ArgumentError("Keep to the agreed categories.")),
)

# Warnings ---------
## Instead of checking the input, We can just issue a warning by default for this Judgement type, so every time it is used, we get a notification: 
@newjudgement(
    Unclear,
    RecordJudgement,
    """
    Something that we have noticed that is unusual and should be discussed.
    """,
    AbstractString,
    x -> warning("This is unusal:", x)
)

## Another use of warnings would be to allert to changes of the Judgement specification. In this example, we have renamed "N" to "NSample": 
# Now we can tell everyone using the N-Judgement to please reconsider:
# commented out because you can not redifine constants in the same session
# @newjudgement(
#     N,
#     """
#     Deprecated! Please use 'NSample' instead.
#     """,
#     Record,
#     AbstractString,
#     x -> warning("'N' was depricated. Please use 'NSample'instead.")
# )


## Or we don't do any of that, and just allow everything: 
@newjudgement(
    Observation,
    AnyLevelJudgement, # may occur anywhere
    """
    An observation without any consequences.
    """,
    Any, # any is the default type anyway
    x -> nothing # this is the default check function anyway
)

# usually metadata are inferred from the DOI but this takes time and an internet connection and can be deactivated
auto_request_meta(true)

############################################################################################

## First we have to define a data base that will store our Records. 
db = RecordDatabase()

# For each Paper, we have to generate a unique ID: 
# generate_id(DOI("10.1007/s10869-019-09648-5"))

# Please format your Code!
# ] add JuliaFormatter
# JuliaFormatter.format("file.jl")

## Now we can produce a new Record and add it to our data base: 
db += test_record = Record(
    rater = "AP",
    id = "823ddb98-f880-5691-aecc-d74b67fbe263",
    location = DOI("10.1007/s10869-019-09648-5"),
    Lang( #This is the Judgement we defined earlier. Within it, we can input the value, the certainty and a comments like before: 
        "de",
        0.5, # not clear what language the paper has
        "abstract in both de and en", # because the abstract exists in both english and german
    ), 
    Study(
        N(100, 0.8, "the abstract says 120 but table 1 is saying 100"),
        Model(Measurement(n_variables = 2, loadings = [0.53, 0.95], factor_variance = 0.16)), # they fitted two models to the same dataset
        Model(Measurement(n_variables = 2, loadings = [1, 1], factor_variance = missing))
    ),
    Study( # a second study (i.e. new an different data), much more complex then the first
        N(985),
        Model(LatentPathmodel(
            Structural(
                structural_model =  @StenoGraph begin
                    IP → IB * Weight(0.27)
                    IN → IB * Weight(0.24)
                    DN → IB * Weight(0.12)
                    BC → IB * Weight(-0.14)

                    IP ⇔ IN * Weight(0.01)
                    IP ⇔ DN * Weight(0.38)
                    IP ⇔ BC * Weight(-0.05)
                    IN ⇔ DN * Weight(0.12)
                    IN ⇔ BC * Weight(-0.17)
                    DN ⇔ BC * Weight(-0.10)
                end),
            Dict(
                :IP => Measurement(n_variables = 3, factor_variance = 1.53^2, loadings = missing),
                :IN => Measurement(n_variables = 4, factor_variance = 1.14^2, loadings = missing),
                :DN => Measurement(n_variables = 3, factor_variance = 1.42^2, loadings = missing),
                :BC => Measurement(n_variables = 3, factor_variance = 0.95^2, loadings = missing),
                :IB => Measurement(n_variables = 5, factor_variance = 0.96^2, loadings = missing)
            )
    ))
))
