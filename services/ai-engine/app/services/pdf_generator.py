"""
Manga-style PDF Scroll generator.
Uses Jinja2 for HTML templating + WeasyPrint for PDF rendering.
"""

import os
from pathlib import Path
from jinja2 import Environment, FileSystemLoader
import weasyprint

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

    pdf_bytes = weasyprint.HTML(string=html_content).write_pdf()
    return pdf_bytes
