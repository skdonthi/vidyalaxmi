"""
Manga-style PDF Scroll generator.
Uses Jinja2 for HTML templating + WeasyPrint for PDF rendering.
"""

import os
from pathlib import Path
from jinja2 import Environment, FileSystemLoader

try:
    import weasyprint
    _WEASYPRINT_AVAILABLE = True
except Exception:
    _WEASYPRINT_AVAILABLE = False

try:
    from fpdf import FPDF
    _FPDF_AVAILABLE = True
except Exception:
    _FPDF_AVAILABLE = False

TEMPLATES_DIR = Path(__file__).parent.parent.parent / "templates" / "manga_scroll"

_jinja_env = Environment(
    loader=FileSystemLoader(str(TEMPLATES_DIR)),
    autoescape=True,
)

# Demo topic data — in production, fetched from Supabase
_TOPIC_DATA = {
    "telugu-letters-1": {
        "title_en": "Telugu Letters I",
        "title_te": "తెలుగు అక్షరాలు I",
        "mentor_name": "Arya",
        "mentor_color": "#FF00E5",
        "panels": [
            {
                "type": "intro",
                "title": "The Akshara Adventure",
                "text": "Arya takes you on a journey through the first vowels of Telugu.",
            },
            {
                "type": "lesson",
                "letter": "అ",
                "romanization": "a",
                "example": "ఆపిల్ (Apple)",
                "fun_fact": "అ is the very first letter — like 'a' in every language!",
            },
            {
                "type": "lesson",
                "letter": "ఆ",
                "romanization": "aa",
                "example": "ఆకాశం (Sky)",
                "fun_fact": "ఆ is like holding the 'a' sound for longer!",
            },
            {
                "type": "lesson",
                "letter": "ఇ",
                "romanization": "i",
                "example": "ఇల్లు (House)",
                "fun_fact": "ఇ sounds like 'ee' in 'feet' — short version!",
            },
            {
                "type": "lesson",
                "letter": "ఈ",
                "romanization": "ee",
                "example": "ఈగ (Fly)",
                "fun_fact": "ఈ is the long 'ee' — hold it twice as long!",
            },
            {
                "type": "quiz",
                "question": "Which letter starts 'ఇల్లు'?",
                "answer": "ఇ",
                "hint": "Think of the letter that sounds like a short 'ee'.",
            },
            {
                "type": "summary",
                "title": "Quest Complete! 🏆",
                "text": "You've mastered the first 4 Telugu vowels. Arya is proud of you!",
                "next_topic": "Telugu Letters II",
            },
        ],
    }
}


async def generate_scroll_pdf(topic_id: str, locale: str = "en") -> bytes:
    """Generate manga-style PDF for a topic. Returns PDF bytes."""
    topic_data = _TOPIC_DATA.get(topic_id)
    if not topic_data:
        raise ValueError(f"No topic data found for: {topic_id}")

    template = _jinja_env.get_template("scroll.html")
    html_content = template.render(
        topic=topic_data,
        locale=locale,
        primary_color="#00F2FF",
        secondary_color="#FF00E5",
        success_color="#39FF14",
        bg_color="#050505",
        text_color="#EAEAEA",
    )

    if _WEASYPRINT_AVAILABLE:
        pdf_bytes = weasyprint.HTML(string=html_content).write_pdf()
        return pdf_bytes

    # Fallback: fpdf2 plain-text PDF when WeasyPrint not available
    return _generate_fallback_pdf(topic_data)


def _generate_fallback_pdf(topic: dict) -> bytes:
    """Plain-text PDF via fpdf2 — no system deps required."""
    pdf = FPDF()
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.add_page()

    # Title
    pdf.set_font("Helvetica", "B", 24)
    pdf.set_text_color(0, 242, 255)
    pdf.cell(0, 12, topic["title_en"], ln=True, align="C")
    pdf.ln(4)

    pdf.set_font("Helvetica", "", 14)
    pdf.set_text_color(200, 200, 200)
    pdf.cell(0, 8, f"Guide: {topic['mentor_name']}", ln=True, align="C")
    pdf.ln(8)

    for panel in topic["panels"]:
        if panel["type"] == "intro":
            pdf.set_font("Helvetica", "B", 16)
            pdf.set_text_color(0, 242, 255)
            pdf.cell(0, 10, panel["title"], ln=True)
            pdf.set_font("Helvetica", "", 12)
            pdf.set_text_color(200, 200, 200)
            pdf.multi_cell(0, 7, panel["text"])
            pdf.ln(6)

        elif panel["type"] == "lesson":
            pdf.set_font("Helvetica", "B", 36)
            pdf.set_text_color(255, 0, 229)
            pdf.cell(0, 16, panel["letter"], ln=True)
            pdf.set_font("Helvetica", "", 12)
            pdf.set_text_color(200, 200, 200)
            pdf.cell(0, 7, f"/ {panel['romanization']} /  —  {panel['example']}", ln=True)
            pdf.set_font("Helvetica", "I", 11)
            pdf.set_text_color(0, 242, 255)
            pdf.multi_cell(0, 6, panel["fun_fact"])
            pdf.ln(5)

        elif panel["type"] == "quiz":
            pdf.set_font("Helvetica", "B", 13)
            pdf.set_text_color(57, 255, 20)
            pdf.cell(0, 8, f"Quiz: {panel['question']}", ln=True)
            pdf.set_font("Helvetica", "B", 28)
            pdf.cell(0, 14, f"Answer: {panel['answer']}", ln=True)
            pdf.ln(4)

        elif panel["type"] == "summary":
            pdf.set_font("Helvetica", "B", 16)
            pdf.set_text_color(255, 215, 0)
            pdf.cell(0, 10, panel["title"], ln=True)
            pdf.set_font("Helvetica", "", 12)
            pdf.set_text_color(200, 200, 200)
            pdf.multi_cell(0, 7, panel["text"])
            pdf.ln(3)
            pdf.set_font("Helvetica", "B", 12)
            pdf.set_text_color(0, 242, 255)
            pdf.cell(0, 8, f"Next Quest: {panel['next_topic']}", ln=True)

    return bytes(pdf.output())
