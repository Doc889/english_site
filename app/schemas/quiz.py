"""
Quiz Schemas

Pydantic models for quiz-related requests and responses.
"""

from pydantic import BaseModel, Field, field_validator
from typing import List, Optional


class QuizAnswer(BaseModel):
    """User's answer to a quiz question."""
    question_id: int
    selected_index: int = Field(..., ge=0, le=3)


class QuizSubmission(BaseModel):
    """Complete quiz submission from user."""
    topic_id: str = Field(..., description="Topic identifier (e.g., 'articles')")
    answers: List[QuizAnswer] = Field(..., min_length=1)
    time_spent_seconds: Optional[int] = Field(None, ge=0, description="Time spent on quiz")

    @field_validator('answers')
    @classmethod
    def validate_unique_questions(cls, v):
        """Ensure each question is answered only once."""
        question_ids = [ans.question_id for ans in v]
        if len(question_ids) != len(set(question_ids)):
            raise ValueError("Each question can only be answered once")
        return v


class QuizResult(BaseModel):
    """Quiz result response."""
    total_questions: int
    correct_answers: int
    incorrect_answers: int
    score_percentage: float
    passed: bool
    feedback_message: str
    time_spent_seconds: Optional[int] = None
