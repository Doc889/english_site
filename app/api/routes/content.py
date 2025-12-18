"""
Content Router

API endpoints for topic content (optimized for Next.js SSG).
"""

from fastapi import APIRouter, HTTPException, status, Depends
from sqlalchemy.orm import Session

from app.schemas import (
    TopicContentResponse,
    TopicInfoResponse,
    RuleSectionResponse,
    RuleExampleResponse,
    QuestionResponse,
    QuestionOptionResponse,
    ErrorResponse
)
from app.repositories.topic_repository import TopicRepository
from app.db.base import get_db

router = APIRouter(prefix="/content", tags=["API - Content"])


@router.get("/{topic_id}",
            response_model=TopicContentResponse,
            summary="Get complete topic content",
            responses={
                404: {"model": ErrorResponse, "description": "Topic not found"}
            })
async def get_topic_content(
    topic_id: str,
    db: Session = Depends(get_db)
):
    """
    Get complete topic content including rules, examples, questions, and options.

    This endpoint is optimized for Next.js Static Site Generation (SSG).
    It returns all content needed to render a topic page in a single request.

    - **topic_id**: Topic identifier (e.g., 'articles', 'present-simple')

    Returns:
    - Topic information
    - All rule sections with examples
    - All questions with options
    """
    # Fetch topic with all related content using eager loading
    topic = TopicRepository.get_with_content(db, topic_id)

    if not topic:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Topic '{topic_id}' not found"
        )

    # Convert SQLAlchemy models to Pydantic schemas
    # Build topic info
    topic_info = TopicInfoResponse(
        id=topic.id,
        title=topic.title,
        description=topic.description,
        difficulty=topic.difficulty,
        total_questions=topic.total_questions,
        display_order=topic.display_order
    )

    # Build rules with examples
    rules = [
        RuleSectionResponse(
            id=rule.id,
            title=rule.title,
            content=rule.content,
            display_order=rule.display_order,
            examples=[
                RuleExampleResponse(
                    id=example.id,
                    example_text=example.example_text,
                    display_order=example.display_order
                )
                for example in rule.examples
            ]
        )
        for rule in topic.rule_sections
    ]

    # Build questions with options
    questions = [
        QuestionResponse(
            id=question.id,
            question_text=question.question_text,
            correct_index=question.correct_index,
            explanation=question.explanation,
            display_order=question.display_order,
            options=[
                QuestionOptionResponse(
                    id=option.id,
                    option_text=option.option_text,
                    option_index=option.option_index
                )
                for option in question.options
            ]
        )
        for question in topic.questions
    ]

    return TopicContentResponse(
        info=topic_info,
        rules=rules,
        questions=questions
    )
