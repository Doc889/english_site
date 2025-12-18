"""
Quiz Service

Business logic for quiz grading and feedback.
"""

from fastapi import HTTPException, status
from sqlalchemy.orm import Session

from app.schemas.quiz import QuizSubmission, QuizResult
from app.services.topic_service import TopicService
from app.repositories.question_repository import QuestionRepository
from app.config import settings


class QuizService:
    """Service for handling quiz operations."""

    @staticmethod
    def grade_quiz(db: Session, submission: QuizSubmission) -> QuizResult:
        """
        Grade a quiz submission and provide feedback.

        Args:
            db: Database session
            submission: User's quiz submission

        Returns:
            Quiz result with score and feedback

        Raises:
            HTTPException: If topic not found or validation fails
        """
        # Validate topic exists
        topic = TopicService.get_topic(db, submission.topic_id)

        # Validate number of answers
        if len(submission.answers) != topic.total_questions:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Expected {topic.total_questions} answers, got {len(submission.answers)}"
            )

        # Grade the quiz using actual database answers
        correct_count = QuizService._grade_answers(db, submission)

        # Calculate results
        total = len(submission.answers)
        incorrect_count = total - correct_count
        percentage = (correct_count / total) * 100
        passed = percentage >= settings.passing_score_percentage

        # Generate feedback
        feedback = QuizService._generate_feedback(percentage)

        return QuizResult(
            total_questions=total,
            correct_answers=correct_count,
            incorrect_answers=incorrect_count,
            score_percentage=round(percentage, 2),
            passed=passed,
            feedback_message=feedback,
            time_spent_seconds=submission.time_spent_seconds
        )

    @staticmethod
    def _grade_answers(db: Session, submission: QuizSubmission) -> int:
        """
        Grade quiz answers by comparing with correct answers from database.

        Args:
            db: Database session
            submission: Quiz submission

        Returns:
            Number of correct answers
        """
        correct_count = 0

        # Get all question IDs from submission
        question_ids = [answer.question_id for answer in submission.answers]

        # Fetch all questions at once for efficiency
        questions_dict = {
            q.id: q for q in QuestionRepository.get_by_ids(db, question_ids)
        }

        # Check each answer
        for answer in submission.answers:
            question = questions_dict.get(answer.question_id)
            if question and question.correct_index == answer.selected_index:
                correct_count += 1

        return correct_count

    @staticmethod
    def _generate_feedback(percentage: float) -> str:
        """
        Generate personalized feedback based on score.

        Args:
            percentage: Score percentage

        Returns:
            Feedback message
        """
        if percentage == 100:
            return "🎉 Perfect score! You're a master of this topic!"
        elif percentage >= 90:
            return "🌟 Excellent work! Outstanding performance!"
        elif percentage >= 80:
            return "👏 Great job! You've got a strong grasp of this topic!"
        elif percentage >= settings.passing_score_percentage:
            return "✓ Good work! You passed! Keep practicing to improve further."
        elif percentage >= 50:
            return "📚 Not bad! Review the material and try again."
        else:
            return "💪 Keep studying! Review the rules and examples carefully."
