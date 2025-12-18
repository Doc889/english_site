"""Repository package for database access."""

from app.repositories.topic_repository import TopicRepository
from app.repositories.question_repository import QuestionRepository

__all__ = ["TopicRepository", "QuestionRepository"]
