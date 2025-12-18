"""API routes package."""

from .pages import router as pages_router
from .topics import router as topics_router
from .quiz import router as quiz_router
from .system import router as system_router
from .content import router as content_router

__all__ = [
    "pages_router",
    "topics_router",
    "quiz_router",
    "system_router",
    "content_router",
]
