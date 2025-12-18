"""
System Router

API endpoints for system health and statistics.
"""

from fastapi import APIRouter
from datetime import datetime

from app.schemas import HealthCheck, PlatformStats
from app.models import get_all_topics
from app.config import settings

router = APIRouter(tags=["System"])


@router.get("/health",
            response_model=HealthCheck,
            summary="Health check")
async def health_check():
    """
    Check if the API is running and healthy.
    """
    return HealthCheck(
        status="healthy",
        timestamp=datetime.utcnow(),
        version=settings.app_version
    )


@router.get("/api/stats",
            response_model=PlatformStats,
            summary="Get platform statistics",
            tags=["API - Stats"])
async def get_platform_stats():
    """
    Get overall platform statistics.

    In production, this would include:
    - Total registered users
    - Total quiz attempts
    - Average scores
    - Popular topics
    """
    topics = get_all_topics()

    # Count topics by difficulty
    difficulty_counts = {}
    for topic in topics:
        diff = topic.difficulty
        difficulty_counts[diff] = difficulty_counts.get(diff, 0) + 1

    total_questions = sum(t.total_questions for t in topics)

    return PlatformStats(
        total_topics=len(topics),
        topics_by_difficulty=difficulty_counts,
        total_questions=total_questions,
        status="operational"
    )
