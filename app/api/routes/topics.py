"""
Topics Router

API endpoints for topic information.
"""

from fastapi import APIRouter, Query, Depends
from typing import Optional
from sqlalchemy.orm import Session

from app.schemas import TopicInfo, ErrorResponse
from app.services import TopicService
from app.db.base import get_db

router = APIRouter(prefix="/topics", tags=["API - Topics"])


@router.get("",
            response_model=list[TopicInfo],
            summary="Get all topics")
async def get_all_topics(
    difficulty: Optional[str] = Query(None, description="Filter by difficulty level"),
    db: Session = Depends(get_db)
):
    """
    Get a list of all available learning topics.

    - **difficulty**: Optional filter by difficulty (beginner, intermediate, advanced)
    """
    return TopicService.get_all_topics(db, difficulty=difficulty)


@router.get("/{topic_id}",
            response_model=TopicInfo,
            summary="Get topic information",
            responses={
                404: {"model": ErrorResponse, "description": "Topic not found"}
            })
async def get_topic_info(
    topic_id: str,
    db: Session = Depends(get_db)
):
    """
    Get detailed information about a specific topic.

    - **topic_id**: Identifier for the topic
    """
    return TopicService.get_topic(db, topic_id)
