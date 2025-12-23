"""Topics API routes"""
from fastapi import APIRouter, HTTPException
from typing import List, Dict
from pathlib import Path

router = APIRouter()

# Static topic data (embedded from static site)
TOPICS_DATA = [
    {
        "id": "alphabet-pronunciation",
        "title": "Закладываем фундамент",
        "description": "Базовые принципы английского языка: структура, глаголы и конструкции",
        "difficulty": "beginner",
        "total_questions": 14
    },
    {
        "id": "greetings-introductions",
        "title": "Существительные",
        "description": "Исчисляемые и неисчисляемые существительные, множественное число",
        "difficulty": "beginner",
        "total_questions": 8
    },
    {
        "id": "articles",
        "title": "Артикли",
        "description": "Артикли a, an, the и нулевой артикль",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "pronouns",
        "title": "Местоимения",
        "description": "Личные, объектные, притяжательные и указательные местоимения",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "adjectives",
        "title": "Прилагательные",
        "description": "Позиция прилагательных, степени сравнения и формы",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "to_be",
        "title": "Глагол to be",
        "description": "Глагол to be (am/is/are) - самый базовый глагол английского языка",
        "difficulty": "beginner",
        "total_questions": 173
    },
    {
        "id": "present_simple",
        "title": "Present Simple",
        "description": "Настоящее простое время - факты, привычки и рутина",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "modal_verbs",
        "title": "Модальные глаголы",
        "description": "Can, must, should - модальные глаголы для выражения способности, необходимости и совета",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "there_is_are",
        "title": "There is / There are",
        "description": "Конструкция для описания наличия предметов и людей",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "prepositions_place",
        "title": "Предлоги места",
        "description": "Предлоги in, on, under, next to, between для описания местоположения",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "question_words",
        "title": "Вопросительные слова",
        "description": "What, where, who, when, why, how - основные вопросительные слова",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "numbers_dates_time",
        "title": "Числа, даты и время",
        "description": "Как называть числа, даты и время по-английски",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "present_continuous",
        "title": "Present Continuous",
        "description": "Настоящее продолженное время для действий, происходящих сейчас",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "future_simple",
        "title": "Future Simple (Will)",
        "description": "Будущее простое время — предсказания, обещания, спонтанные решения",
        "difficulty": "beginner",
        "total_questions": 174
    },
    {
        "id": "be_going_to",
        "title": "Be Going To",
        "description": "Конструкция be going to для планов и намерений",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "past_simple",
        "title": "Past Simple",
        "description": "Прошедшее простое время для завершенных действий",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "past_continuous",
        "title": "Past Continuous",
        "description": "Прошедшее продолженное время",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "present_perfect",
        "title": "Present Perfect",
        "description": "Настоящее совершенное время",
        "difficulty": "beginner",
        "total_questions": 200
    },
    {
        "id": "comparatives_superlatives",
        "title": "Comparatives and Superlatives",
        "description": "Степени сравнения прилагательных",
        "difficulty": "beginner",
        "total_questions": 200
    }
]


@router.get("/topics", response_model=List[Dict])
async def get_topics(difficulty: str = None):
    """Get all topics or filter by difficulty"""
    if difficulty:
        return [t for t in TOPICS_DATA if t["difficulty"] == difficulty]
    return TOPICS_DATA


@router.get("/topics/{topic_id}", response_model=Dict)
async def get_topic(topic_id: str):
    """Get specific topic by ID"""
    topic = next((t for t in TOPICS_DATA if t["id"] == topic_id), None)
    if not topic:
        raise HTTPException(status_code=404, detail="Topic not found")
    return topic


@router.get("/stats")
async def get_stats():
    """Get platform statistics"""
    total_questions = sum(t["total_questions"] for t in TOPICS_DATA)
    return {
        "total_topics": len(TOPICS_DATA),
        "total_questions": total_questions,
        "topics_by_difficulty": {
            "beginner": len([t for t in TOPICS_DATA if t["difficulty"] == "beginner"])
        },
        "average_questions_per_topic": round(total_questions / len(TOPICS_DATA), 1)
    }
