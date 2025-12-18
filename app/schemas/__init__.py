"""Schemas package - Pydantic models for request/response validation."""

from .common import ErrorResponse, HealthCheck, PlatformStats
from .topic import TopicInfo, RuleSection, Question, TopicContent
from .quiz import QuizAnswer, QuizSubmission, QuizResult
from .content import (
    TopicContentResponse,
    TopicInfoResponse,
    RuleSectionResponse,
    RuleExampleResponse,
    QuestionResponse,
    QuestionOptionResponse
)

__all__ = [
    # Common
    "ErrorResponse",
    "HealthCheck",
    "PlatformStats",
    # Topic
    "TopicInfo",
    "RuleSection",
    "Question",
    "TopicContent",
    # Quiz
    "QuizAnswer",
    "QuizSubmission",
    "QuizResult",
    # Content (for Next.js)
    "TopicContentResponse",
    "TopicInfoResponse",
    "RuleSectionResponse",
    "RuleExampleResponse",
    "QuestionResponse",
    "QuestionOptionResponse",
]
