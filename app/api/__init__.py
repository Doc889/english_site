"""API package."""

from fastapi import APIRouter
from .routes import pages_router, topics_router, quiz_router, system_router, content_router

# Create main API router
api_router = APIRouter()

# Include all route modules
api_router.include_router(topics_router)
api_router.include_router(quiz_router)
api_router.include_router(content_router)

__all__ = [
    "api_router",
    "pages_router",
    "system_router",
]
