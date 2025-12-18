"""Topic repository for database operations."""

from typing import List, Optional
from sqlalchemy.orm import Session, joinedload
from app.db.models import Topic, RuleSection, Question


class TopicRepository:
    """Repository for Topic-related database operations."""

    @staticmethod
    def get_all(db: Session, difficulty: Optional[str] = None) -> List[Topic]:
        """
        Get all topics, optionally filtered by difficulty.

        Args:
            db: Database session
            difficulty: Optional difficulty filter ('beginner', 'intermediate', 'advanced')

        Returns:
            List of Topic objects ordered by display_order
        """
        query = db.query(Topic).order_by(Topic.display_order)

        if difficulty:
            query = query.filter(Topic.difficulty == difficulty)

        return query.all()

    @staticmethod
    def get_by_id(db: Session, topic_id: str) -> Optional[Topic]:
        """
        Get a topic by ID without related data.

        Args:
            db: Database session
            topic_id: Topic ID

        Returns:
            Topic object or None if not found
        """
        return db.query(Topic).filter(Topic.id == topic_id).first()

    @staticmethod
    def get_with_content(db: Session, topic_id: str) -> Optional[Topic]:
        """
        Get a topic with all related content (rules, examples, questions, options).
        Uses eager loading for performance.

        Args:
            db: Database session
            topic_id: Topic ID

        Returns:
            Topic object with all relationships loaded, or None if not found
        """
        return (
            db.query(Topic)
            .options(
                # Load rule sections with their examples
                joinedload(Topic.rule_sections).joinedload(RuleSection.examples),
                # Load questions with their options
                joinedload(Topic.questions).joinedload(Question.options)
            )
            .filter(Topic.id == topic_id)
            .first()
        )

    @staticmethod
    def get_rules_by_topic(db: Session, topic_id: str) -> List[RuleSection]:
        """
        Get all rule sections for a topic (with examples).

        Args:
            db: Database session
            topic_id: Topic ID

        Returns:
            List of RuleSection objects with examples loaded
        """
        return (
            db.query(RuleSection)
            .options(joinedload(RuleSection.examples))
            .filter(RuleSection.topic_id == topic_id)
            .order_by(RuleSection.display_order)
            .all()
        )

    @staticmethod
    def count_topics(db: Session) -> int:
        """
        Count total number of topics.

        Args:
            db: Database session

        Returns:
            Total count of topics
        """
        return db.query(Topic).count()

    @staticmethod
    def get_topics_summary(db: Session) -> List[dict]:
        """
        Get summary of all topics (ID, title, description, difficulty).
        Lightweight query for listing topics.

        Args:
            db: Database session

        Returns:
            List of dictionaries with topic summary data
        """
        topics = (
            db.query(
                Topic.id,
                Topic.title,
                Topic.description,
                Topic.difficulty,
                Topic.total_questions,
                Topic.display_order
            )
            .order_by(Topic.display_order)
            .all()
        )

        return [
            {
                "id": t.id,
                "title": t.title,
                "description": t.description,
                "difficulty": t.difficulty,
                "total_questions": t.total_questions,
                "display_order": t.display_order
            }
            for t in topics
        ]
