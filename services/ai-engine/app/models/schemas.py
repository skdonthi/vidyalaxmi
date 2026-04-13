from pydantic import BaseModel, Field
from typing import Optional
from enum import Enum


class Difficulty(int, Enum):
    one = 1
    two = 2
    three = 3
    four = 4
    five = 5


class ADLInput(BaseModel):
    user_id: str
    topic_id: str
    is_correct: bool
    response_time_ms: int = Field(ge=0, le=60000)
    current_difficulty: int = Field(ge=1, le=5)

    class Config:
        json_schema_extra = {
            "example": {
                "user_id": "uuid-here",
                "topic_id": "telugu-letters-1",
                "is_correct": True,
                "response_time_ms": 3200,
                "current_difficulty": 2,
            }
        }


class ADLOutput(BaseModel):
    new_difficulty: int
    weighted_score: float
    performance_label: str  # "excellent" | "good" | "needs_practice"
    encouragement: str


class ScrollRequest(BaseModel):
    topic_id: str
    user_id: str
    locale: str = "en"
    include_mentor: bool = True


class TranslationRequest(BaseModel):
    text: str
    source_lang: str = "en"
    target_lang: str
    task: str = "translation"  # "translation" | "tts" | "transliteration"


class TranslationResponse(BaseModel):
    translated_text: Optional[str] = None
    tts_audio_base64: Optional[str] = None
    error: Optional[str] = None


class AnalyticsEvent(BaseModel):
    user_id: str
    topic_id: str
    event_type: str  # "jingle_play", "question_answered", "boss_fight_complete"
    payload: dict = {}
    locale: str = "en"
