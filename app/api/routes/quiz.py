"""
Quiz Router

API endpoints for quiz submission and grading.
"""

from fastapi import APIRouter, status, Depends
from sqlalchemy.orm import Session

from app.schemas import QuizSubmission, QuizResult, ErrorResponse
from app.services import QuizService
from app.db.base import get_db

router = APIRouter(prefix="/quiz", tags=["API - Quiz"])


@router.post("/submit",
             response_model=QuizResult,
             status_code=status.HTTP_200_OK,
             summary="Submit quiz answers",
             responses={
                 200: {"description": "Quiz graded successfully"},
                 400: {"model": ErrorResponse, "description": "Invalid submission"},
                 404: {"model": ErrorResponse, "description": "Topic not found"}
             })
async def submit_quiz(
    submission: QuizSubmission,
    db: Session = Depends(get_db)
):
    """
    Submit quiz answers for grading.

    Returns detailed results including score, correct/incorrect counts,
    and personalized feedback.

    - **submission**: Quiz answers and metadata
    """
    return QuizService.grade_quiz(db, submission)
