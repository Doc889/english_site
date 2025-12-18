"""Question repository for database operations."""

from typing import List, Optional
from sqlalchemy.orm import Session, joinedload
from app.db.models import Question, QuestionOption


class QuestionRepository:
    """Repository for Question-related database operations."""

    @staticmethod
    def get_by_topic(db: Session, topic_id: str) -> List[Question]:
        """
        Get all questions for a topic with their options.

        Args:
            db: Database session
            topic_id: Topic ID

        Returns:
            List of Question objects with options loaded, ordered by display_order
        """
        return (
            db.query(Question)
            .options(joinedload(Question.options))
            .filter(Question.topic_id == topic_id)
            .order_by(Question.display_order)
            .all()
        )

    @staticmethod
    def get_by_id(db: Session, question_id: int) -> Optional[Question]:
        """
        Get a single question by ID with its options.

        Args:
            db: Database session
            question_id: Question ID

        Returns:
            Question object with options loaded, or None if not found
        """
        return (
            db.query(Question)
            .options(joinedload(Question.options))
            .filter(Question.id == question_id)
            .first()
        )

    @staticmethod
    def get_by_ids(db: Session, question_ids: List[int]) -> List[Question]:
        """
        Get multiple questions by IDs with their options.

        Args:
            db: Database session
            question_ids: List of question IDs

        Returns:
            List of Question objects with options loaded
        """
        return (
            db.query(Question)
            .options(joinedload(Question.options))
            .filter(Question.id.in_(question_ids))
            .all()
        )

    @staticmethod
    def count_by_topic(db: Session, topic_id: str) -> int:
        """
        Count total questions for a topic.

        Args:
            db: Database session
            topic_id: Topic ID

        Returns:
            Total count of questions for the topic
        """
        return db.query(Question).filter(Question.topic_id == topic_id).count()

    @staticmethod
    def get_random_questions(
        db: Session, topic_id: str, limit: int = 10
    ) -> List[Question]:
        """
        Get random questions from a topic (useful for practice mode).

        Args:
            db: Database session
            topic_id: Topic ID
            limit: Number of random questions to retrieve

        Returns:
            List of random Question objects with options loaded
        """
        from sqlalchemy import func

        return (
            db.query(Question)
            .options(joinedload(Question.options))
            .filter(Question.topic_id == topic_id)
            .order_by(func.random())
            .limit(limit)
            .all()
        )

    @staticmethod
    def validate_answer(db: Session, question_id: int, selected_index: int) -> bool:
        """
        Check if the selected answer is correct.

        Args:
            db: Database session
            question_id: Question ID
            selected_index: Index of the selected option (0-3)

        Returns:
            True if answer is correct, False otherwise
        """
        question = db.query(Question).filter(Question.id == question_id).first()
        if not question:
            return False

        return question.correct_index == selected_index
