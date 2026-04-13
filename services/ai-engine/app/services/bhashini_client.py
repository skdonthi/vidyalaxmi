"""
Bhashini API client.
Docs: https://bhashini.gitbook.io/bhashini-apis
Flow: Pipeline Config → Pipeline Compute
"""

import os
import httpx
from typing import Optional

BHASHINI_USER_ID = os.getenv("BHASHINI_USER_ID", "")
BHASHINI_API_KEY = os.getenv("BHASHINI_API_KEY", "")
BHASHINI_INFERENCE_KEY = os.getenv("BHASHINI_INFERENCE_KEY", "")

PIPELINE_CONFIG_URL = "https://meity-auth.ulcacontrib.org/ulca/apis/v0/model/getModelsPipeline"
PIPELINE_COMPUTE_URL = "https://dhruva-api.bhashini.gov.in/services/inference/pipeline"

LANG_CODES = {
    "en": "en",
    "te": "te",
    "hi": "hi",
    "ta": "ta",
    "kn": "kn",
    "ml": "ml",
    "bn": "bn",
    "gu": "gu",
    "mr": "mr",
    "pa": "pa",
}


async def translate(
    text: str,
    source_lang: str,
    target_lang: str,
) -> Optional[str]:
    """Translate text via Bhashini IndicTrans2."""
    if not BHASHINI_USER_ID:
        return _fallback_translate(text, source_lang, target_lang)

    headers = {
        "userID": BHASHINI_USER_ID,
        "ulcaApiKey": BHASHINI_API_KEY,
        "Content-Type": "application/json",
    }

    # Step 1: Pipeline Config
    config_payload = {
        "pipelineTasks": [{"taskType": "translation", "config": {
            "language": {"sourceLanguage": source_lang, "targetLanguage": target_lang}
        }}],
        "pipelineRequestConfig": {"pipelineId": "64392f96daac500b55c543cd"},
    }

    async with httpx.AsyncClient(timeout=30) as client:
        config_resp = await client.post(
            PIPELINE_CONFIG_URL, json=config_payload, headers=headers
        )
        config_resp.raise_for_status()
        config_data = config_resp.json()

        pipeline_id = config_data["pipelineResponseConfig"][0]["config"][0]["serviceId"]
        compute_url = config_data["pipelineInferenceAPIEndPoint"]["callbackUrl"]
        inference_key = config_data["pipelineInferenceAPIEndPoint"]["inferenceApiKey"]["value"]

        # Step 2: Pipeline Compute
        compute_headers = {
            "Authorization": inference_key,
            "Content-Type": "application/json",
        }
        compute_payload = {
            "pipelineTasks": [{
                "taskType": "translation",
                "config": {
                    "language": {"sourceLanguage": source_lang, "targetLanguage": target_lang},
                    "serviceId": pipeline_id,
                }
            }],
            "inputData": {"input": [{"source": text}]},
        }

        compute_resp = await client.post(compute_url, json=compute_payload, headers=compute_headers)
        compute_resp.raise_for_status()
        result = compute_resp.json()

        return result["pipelineResponse"][0]["output"][0]["target"]


async def text_to_speech(text: str, lang: str) -> Optional[str]:
    """TTS via Bhashini. Returns base64-encoded audio."""
    if not BHASHINI_USER_ID:
        return None  # No fallback for TTS

    headers = {
        "userID": BHASHINI_USER_ID,
        "ulcaApiKey": BHASHINI_API_KEY,
        "Content-Type": "application/json",
    }

    config_payload = {
        "pipelineTasks": [{"taskType": "tts", "config": {
            "language": {"sourceLanguage": lang}
        }}],
        "pipelineRequestConfig": {"pipelineId": "64392f96daac500b55c543cd"},
    }

    async with httpx.AsyncClient(timeout=30) as client:
        config_resp = await client.post(PIPELINE_CONFIG_URL, json=config_payload, headers=headers)
        config_resp.raise_for_status()
        config_data = config_resp.json()

        pipeline_id = config_data["pipelineResponseConfig"][0]["config"][0]["serviceId"]
        compute_url = config_data["pipelineInferenceAPIEndPoint"]["callbackUrl"]
        inference_key = config_data["pipelineInferenceAPIEndPoint"]["inferenceApiKey"]["value"]

        compute_payload = {
            "pipelineTasks": [{
                "taskType": "tts",
                "config": {
                    "language": {"sourceLanguage": lang},
                    "serviceId": pipeline_id,
                    "gender": "female",
                }
            }],
            "inputData": {"input": [{"source": text}]},
        }

        compute_resp = await client.post(
            compute_url,
            json=compute_payload,
            headers={"Authorization": inference_key, "Content-Type": "application/json"},
        )
        compute_resp.raise_for_status()
        result = compute_resp.json()
        return result["pipelineResponse"][0]["audio"][0]["audioContent"]


def _fallback_translate(text: str, source: str, target: str) -> str:
    """Returns original text when Bhashini is unconfigured (dev fallback)."""
    return f"[{target}] {text}"
