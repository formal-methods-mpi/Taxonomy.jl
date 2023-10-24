abstract type JudgementLevel end
struct AnyLevelJudgement <: JudgementLevel end
struct RecordJudgement <: JudgementLevel end
struct StudyJudgement <: JudgementLevel end


judgements(x::JudgementLevel) = x.judgements
