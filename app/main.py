"""FastAPI application - serves static site and provides API routes"""
from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from pathlib import Path

from app.config import settings
from app.api.routes import topics, health


# Create FastAPI app
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    docs_url="/api/docs",
    redoc_url="/api/redoc",
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API routes
app.include_router(health.router, prefix="/api", tags=["Health"])
app.include_router(topics.router, prefix="/api", tags=["Topics"])

# Mount static files
static_path = Path(__file__).parent.parent / "static_site"
app.mount("/static", StaticFiles(directory=str(static_path)), name="static")


@app.get("/")
async def root():
    """Serve the main index.html page"""
    index_file = static_path / "index.html"
    return FileResponse(index_file)


@app.get("/topics/{topic_id}")
async def serve_topic(topic_id: str):
    """Serve topic pages"""
    topic_file = static_path / "topics" / f"{topic_id}.html"
    if topic_file.exists():
        return FileResponse(topic_file)
    return {"error": "Topic not found"}, 404


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host=settings.HOST,
        port=settings.PORT,
        reload=settings.DEBUG
    )
