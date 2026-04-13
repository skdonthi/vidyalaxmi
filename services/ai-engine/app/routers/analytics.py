import os
from fastapi import APIRouter
from app.models.schemas import AnalyticsEvent
from supabase import create_client

router = APIRouter()

_supabase = None

def _get_supabase():
    global _supabase
    if _supabase is None:
        url = os.getenv("SUPABASE_URL", "")
        key = os.getenv("SUPABASE_SERVICE_ROLE_KEY", "")
        if url and key:
            _supabase = create_client(url, key)
    return _supabase


@router.post("/event")
async def record_event(event: AnalyticsEvent) -> dict:
    """Record a learning event for anonymized heatmap analytics."""
    sb = _get_supabase()
    if sb:
        # Store anonymized event — no PII
        sb.table("analytics_events").insert({
            "topic_id": event.topic_id,
            "event_type": event.event_type,
            "locale": event.locale,
            "payload": event.payload,
        }).execute()

    return {"recorded": True}


@router.get("/heatmap/{topic_id}")
async def topic_heatmap(topic_id: str) -> dict:
    """Return aggregated performance heatmap for a topic."""
    sb = _get_supabase()
    if not sb:
        return {"topic_id": topic_id, "data": []}

    result = (
        sb.table("progress")
        .select("accuracy_avg, response_time_avg, current_difficulty")
        .eq("topic_id", topic_id)
        .execute()
    )

    rows = result.data or []
    if not rows:
        return {"topic_id": topic_id, "data": [], "avg_accuracy": 0, "avg_difficulty": 0}

    avg_acc = sum(r["accuracy_avg"] or 0 for r in rows) / len(rows)
    avg_diff = sum(r["current_difficulty"] or 1 for r in rows) / len(rows)

    return {
        "topic_id": topic_id,
        "sample_size": len(rows),
        "avg_accuracy": round(avg_acc, 3),
        "avg_difficulty": round(avg_diff, 2),
        "data": rows,
    }
