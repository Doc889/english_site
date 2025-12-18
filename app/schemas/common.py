"""
Common Schemas

Shared Pydantic models used across the application.
"""

from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional


class ErrorResponse(BaseModel):
    """Standard error response schema."""
    detail: str
    error_code: Optional[str] = None
    timestamp: datetime = Field(default_factory=datetime.utcnow)


class HealthCheck(BaseModel):
    """Health check response schema."""
    status: str
    timestamp: datetime
    version: str


class PlatformStats(BaseModel):
    """Platform statistics schema."""
    total_topics: int
    topics_by_difficulty: dict[str, int]
    total_questions: int
    status: str
