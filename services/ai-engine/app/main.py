from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from app.routers import adl, scroll, bhashini, analytics


@asynccontextmanager
async def lifespan(app: FastAPI):
    print("VidyaLaxmi AI Engine starting up…")
    yield
    print("VidyaLaxmi AI Engine shutting down…")


app = FastAPI(
    title="VidyaLaxmi AI Engine",
    description="Adaptive Difficulty Loop, Scroll PDF generation, Bhashini proxy, Analytics",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(adl.router, prefix="/adl", tags=["ADL"])
app.include_router(scroll.router, prefix="/scroll", tags=["Scroll"])
app.include_router(bhashini.router, prefix="/bhashini", tags=["Bhashini"])
app.include_router(analytics.router, prefix="/analytics", tags=["Analytics"])


@app.get("/health")
async def health():
    return {"status": "ok", "service": "vidyalaxmi-ai-engine"}
