"""
Topic Schemas

Pydantic models for topic-related requests and responses.
"""

from pydantic import BaseModel, Field
from typing import List


class TopicInfo(BaseModel):
    """Information about a learning topic."""
    id: str
    title: str
    description: str
    difficulty: str = Field(..., description="beginner, intermediate, or advanced")
    filename: str
    total_questions: int


class RuleSection(BaseModel):
    """A rule section within a topic."""
    title: str
    content: str
    examples: List[str]


class Question(BaseModel):
    """Quiz question model."""
    id: int
    question_text: str
    options: List[str] = Field(..., min_length=4, max_length=4)
    correct_index: int = Field(..., ge=0, le=3)
    explanation: str


class TopicContent(BaseModel):
    """Complete content for a topic including rules and questions."""
    info: TopicInfo
    rules: List[RuleSection]
    questions: List[Question]
