"""
Topic Service

Business logic for topic-related operations.
"""

from pathlib import Path
from typing import Optional
from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.repositories.topic_repository import TopicRepository
from app.schemas.topic import TopicInfo
from app.config import settings


class TopicService:
    """Service for handling topic operations."""

    @staticmethod
    def get_all_topics(db: Session, difficulty: Optional[str] = None) -> list[TopicInfo]:
        """
        Get all topics, optionally filtered by difficulty.

        Args:
            db: Database session
            difficulty: Optional difficulty filter (beginner, intermediate, advanced)

        Returns:
            List of topics
        """
        topics = TopicRepository.get_all(db, difficulty=difficulty)

        # Convert SQLAlchemy models to Pydantic schemas
        return [
            TopicInfo(
                id=topic.id,
                title=topic.title,
                description=topic.description,
                difficulty=topic.difficulty,
                total_questions=topic.total_questions,
                filename=f"{topic.id}.html"  # Keep for backward compatibility
            )
            for topic in topics
        ]

    @staticmethod
    def get_topic(db: Session, topic_id: str) -> TopicInfo:
        """
        Get a specific topic by ID.

        Args:
            db: Database session
            topic_id: Topic identifier

        Returns:
            Topic information

        Raises:
            HTTPException: If topic not found
        """
        topic = TopicRepository.get_by_id(db, topic_id)
        if not topic:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Topic '{topic_id}' not found"
            )

        return TopicInfo(
            id=topic.id,
            title=topic.title,
            description=topic.description,
            difficulty=topic.difficulty,
            total_questions=topic.total_questions,
            filename=f"{topic.id}.html"  # Keep for backward compatibility
        )

    @staticmethod
    def get_topic_html_path(db: Session, topic_id: str) -> Path:
        """
        Get the file path for a topic's HTML page.

        Args:
            db: Database session
            topic_id: Topic identifier

        Returns:
            Path to HTML file

        Raises:
            HTTPException: If topic not found or file doesn't exist
        """
        topic = TopicService.get_topic(db, topic_id)
        filepath = settings.topics_dir / topic.filename

        if not filepath.exists():
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"Topic page file not found: {topic.filename}"
            )

        return filepath

    @staticmethod
    def read_topic_html(db: Session, topic_id: str) -> str:
        """
        Read the HTML content for a topic.

        Args:
            db: Database session
            topic_id: Topic identifier

        Returns:
            HTML content as string

        Raises:
            HTTPException: If file cannot be read
        """
        filepath = TopicService.get_topic_html_path(db, topic_id)

        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                return f.read()
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error reading topic page: {str(e)}"
            )
