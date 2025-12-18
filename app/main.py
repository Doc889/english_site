"""
Main Application Module

FastAPI application initialization and configuration.
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.config import settings
from app.api import api_router
from app.api.routes import pages_router, system_router


def create_application() -> FastAPI:
    """
    Create and configure FastAPI application.

    Returns:
        Configured FastAPI application instance
    """
    app = FastAPI(
        title=settings.app_name,
        description=settings.app_description,
        version=settings.app_version,
        docs_url=settings.docs_url,
        redoc_url=settings.redoc_url
    )

    # Configure CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_credentials=settings.cors_credentials,
        allow_methods=settings.cors_methods,
        allow_headers=settings.cors_headers,
    )

    # Include routers
    app.include_router(pages_router)  # HTML pages (no prefix)
    app.include_router(system_router)  # Health check (no prefix)
    app.include_router(api_router, prefix=settings.api_prefix)  # API endpoints

    # Exception handlers
    @app.exception_handler(ValueError)
    async def value_error_handler(request, exc: ValueError):
        """Handle validation errors."""
        return JSONResponse(
            status_code=400,
            content={"detail": str(exc), "error_code": "VALIDATION_ERROR"}
        )

    @app.exception_handler(Exception)
    async def general_exception_handler(request, exc: Exception):
        """Handle unexpected errors."""
        # In production, log this error
        return JSONResponse(
            status_code=500,
            content={"detail": "An unexpected error occurred", "error_code": "INTERNAL_ERROR"}
        )

    return app


# Create application instance
app = create_application()


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host=settings.host,
        port=settings.port,
        reload=settings.debug,
        log_level="info"
    )
