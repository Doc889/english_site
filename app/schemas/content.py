"""
Content Schemas

Pydantic models for topic content responses (for Next.js frontend).
"""

from pydantic import BaseModel, Field
from typing import List


class RuleExampleResponse(BaseModel):
    """Schema for a rule example."""

    id: int
    example_text: str
    display_order: int

    class Config:
        from_attributes = True


class RuleSectionResponse(BaseModel):
    """Schema for a rule section with examples."""

    id: int
    title: str
    content: str
    display_order: int
    examples: List[RuleExampleResponse] = Field(default_factory=list)

    class Config:
        from_attributes = True


class QuestionOptionResponse(BaseModel):
    """Schema for a question option."""

    id: int
    option_text: str
    option_index: int

    class Config:
        from_attributes = True


class QuestionResponse(BaseModel):
    """Schema for a question with options."""

    id: int
    question_text: str
    correct_index: int
    explanation: str
    display_order: int
    options: List[QuestionOptionResponse] = Field(default_factory=list)

    class Config:
        from_attributes = True


class TopicContentResponse(BaseModel):
    """Schema for complete topic content (for Next.js pages)."""

    info: "TopicInfoResponse"
    rules: List[RuleSectionResponse] = Field(default_factory=list)
    questions: List[QuestionResponse] = Field(default_factory=list)

    class Config:
        from_attributes = True


class TopicInfoResponse(BaseModel):
    """Schema for topic basic information."""

    id: str
    title: str
    description: str
    difficulty: str
    total_questions: int
    display_order: int

    class Config:
        from_attributes = True


# Update forward references
TopicContentResponse.model_rebuild()
