from fastapi import APIRouter, HTTPException
from fastapi.responses import Response
from app.models.schemas import ScrollRequest
from app.services.pdf_generator import generate_scroll_pdf

router = APIRouter()


@router.get("/generate/{topic_id}")
async def generate_scroll(topic_id: str, locale: str = "en") -> Response:
    """Generate and return a manga-style PDF cheat sheet for a topic."""
    try:
        pdf_bytes = await generate_scroll_pdf(topic_id, locale)
        return Response(
            content=pdf_bytes,
            media_type="application/pdf",
            headers={
                "Content-Disposition": f'attachment; filename="scroll_{topic_id}.pdf"',
                "Cache-Control": "no-cache",
            },
        )
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"PDF generation failed: {e}")


@router.post("/generate")
async def generate_scroll_post(req: ScrollRequest) -> Response:
    """POST variant for authenticated scroll generation with user tracking."""
    try:
        pdf_bytes = await generate_scroll_pdf(req.topic_id, req.locale)
        return Response(
            content=pdf_bytes,
            media_type="application/pdf",
            headers={
                "Content-Disposition": f'attachment; filename="scroll_{req.topic_id}.pdf"',
            },
        )
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"PDF generation failed: {e}")
