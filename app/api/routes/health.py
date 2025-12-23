"""Health check routes"""
from fastapi import APIRouter
from datetime import datetime

router = APIRouter()


@router.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "version": "2.0.0"
    }


@router.get("/info")
async def app_info():
    """Application information"""
    return {
        "app_name": "English Learning Platform",
        "version": "2.0.0",
        "type": "Static site with API",
        "features": [
            "19 English learning topics",
            "2,569+ quiz questions",
            "Fully static content",
            "API endpoints for extensions"
        ]
    }
