from fastapi import APIRouter, HTTPException
from app.models.schemas import TranslationRequest, TranslationResponse
from app.services.bhashini_client import translate, text_to_speech

router = APIRouter()


@router.post("/translate", response_model=TranslationResponse)
async def translate_text(req: TranslationRequest) -> TranslationResponse:
    """Translate text via Bhashini IndicTrans2 (en↔te, en↔hi, etc.)."""
    try:
        result = await translate(req.text, req.source_lang, req.target_lang)
        return TranslationResponse(translated_text=result)
    except Exception as e:
        return TranslationResponse(error=str(e))


@router.post("/tts", response_model=TranslationResponse)
async def tts(req: TranslationRequest) -> TranslationResponse:
    """Text-to-speech for jingle lyrics via Bhashini."""
    try:
        audio_b64 = await text_to_speech(req.text, req.target_lang)
        return TranslationResponse(tts_audio_base64=audio_b64)
    except Exception as e:
        return TranslationResponse(error=str(e))


@router.get("/languages")
async def supported_languages():
    return {
        "languages": [
            {"code": "en", "name": "English"},
            {"code": "te", "name": "Telugu"},
            {"code": "hi", "name": "Hindi"},
            {"code": "ta", "name": "Tamil"},
            {"code": "kn", "name": "Kannada"},
            {"code": "ml", "name": "Malayalam"},
            {"code": "bn", "name": "Bengali"},
            {"code": "gu", "name": "Gujarati"},
            {"code": "mr", "name": "Marathi"},
            {"code": "pa", "name": "Punjabi"},
        ]
    }
