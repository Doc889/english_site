"""
Pages Router

Endpoints for serving HTML pages.
"""

from fastapi import APIRouter, HTTPException, status, Depends
from fastapi.responses import HTMLResponse
from pathlib import Path
from sqlalchemy.orm import Session

from app.services import TopicService
from app.db.base import get_db

router = APIRouter(tags=["Pages"])


@router.get("/",
            response_class=HTMLResponse,
            summary="Get landing page")
async def get_landing_page():
    """
    Serve the main landing page with all topics.
    """
    try:
        with open("index.html", "r", encoding="utf-8") as f:
            return HTMLResponse(content=f.read())
    except FileNotFoundError:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Landing page not found"
        )


@router.get("/topics/{topic_id}",
            response_class=HTMLResponse,
            summary="Get topic page")
async def get_topic_page(
    topic_id: str,
    db: Session = Depends(get_db)
):
    """
    Serve the HTML page for a specific learning topic.

    - **topic_id**: Identifier for the topic (e.g., 'articles', 'present-simple')
    """
    # Verify topic exists in database (will raise 404 if not found)
    topic = TopicService.get_topic(db, topic_id)

    # Serve the dynamic template (it will fetch data via API)
    try:
        with open("topic-template.html", "r", encoding="utf-8") as f:
            return HTMLResponse(content=f.read())
    except FileNotFoundError:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Topic template not found"
        )
