from fastapi import APIRouter
from app.models.schemas import ADLInput, ADLOutput
from app.services.difficulty_engine import compute_difficulty

router = APIRouter()


@router.post("/evaluate", response_model=ADLOutput)
async def evaluate_answer(payload: ADLInput) -> ADLOutput:
    """
    Evaluate a student answer and return the next difficulty level.

    ADL Algorithm:
      weighted_score = 0.6 * accuracy + 0.4 * (1 - response_time / max_time)
      > 0.7 → difficulty + 1
      < 0.3 → difficulty - 1
      else  → maintain
    """
    result = compute_difficulty(
        is_correct=payload.is_correct,
        response_time_ms=payload.response_time_ms,
        current_difficulty=payload.current_difficulty,
    )
    return ADLOutput(
        new_difficulty=result.new_difficulty,
        weighted_score=result.weighted_score,
        performance_label=result.performance_label,
        encouragement=result.encouragement,
    )
