#!/usr/bin/env python3
"""
Add first quiz questions to the database
"""

import sys
from pathlib import Path

# Add parent directory to path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy.orm import Session
from app.db.base import SessionLocal
from app.db.models import Topic, Question, QuestionOption


def add_first_quiz(db: Session):
    """Add the first quiz questions from first_quiz.txt"""

    topic = db.query(Topic).filter(Topic.id == "alphabet-pronunciation").first()
    if not topic:
        print("⚠️  First topic not found")
        return

    # Clear existing questions and options
    for question in db.query(Question).filter(Question.topic_id == topic.id).all():
        db.query(QuestionOption).filter(QuestionOption.question_id == question.id).delete()
    db.query(Question).filter(Question.topic_id == topic.id).delete()
    db.commit()

    # Quiz questions
    questions_data = [
        {
            "text": "Что в английском языке чаще всего определяет смысл предложения?",
            "options": [
                "Окончания слов",
                "Интонация",
                "Порядок слов",
                "Длина предложения"
            ],
            "correct": 2,  # C
            "explanation": "В английском языке порядок слов определяет смысл предложения, в отличие от русского, где важны окончания."
        },
        {
            "text": "Какая базовая структура английского предложения считается правильной?",
            "options": [
                "Что делает → кто → остальное",
                "Кто → что делает → остальное",
                "Остальное → кто → что делает",
                "Любой порядок допустим"
            ],
            "correct": 1,  # B
            "explanation": "Базовая структура: Подлежащее (кто) → Глагол (что делает) → Остальное."
        },
        {
            "text": "Какое минимальное количество обязательных элементов есть в английском предложении?",
            "options": [
                "Одно слово",
                "Подлежащее и глагол",
                "Подлежащее, глагол и дополнение",
                "Глагол и прилагательное"
            ],
            "correct": 1,  # B
            "explanation": "Минимальное английское предложение состоит из подлежащего и глагола."
        },
        {
            "text": "Почему нельзя сказать просто: Student?",
            "options": [
                "Потому что нужно добавить артикль",
                "Потому что слово слишком короткое",
                "Потому что в предложении нет глагола",
                "Потому что это разговорная форма"
            ],
            "correct": 2,  # C
            "explanation": "В английском предложении всегда должен быть глагол. Правильно: I am a student."
        },
        {
            "text": "Как правильно сказать «Я студент»?",
            "options": [
                "I student",
                "I be student",
                "I am student",
                "I am a student"
            ],
            "correct": 3,  # D
            "explanation": "Правильный вариант включает глагол 'am' и артикль 'a': I am a student."
        },
        {
            "text": "Какой глагол используется, когда нет действия, но есть состояние или описание?",
            "options": [
                "To do",
                "To have",
                "To be",
                "To make"
            ],
            "correct": 2,  # C
            "explanation": "Глагол 'to be' используется для описания состояния, местоположения или идентификации."
        },
        {
            "text": "Выбери правильное предложение:",
            "options": [
                "She tired",
                "She is tired",
                "Is tired she",
                "She tired is"
            ],
            "correct": 1,  # B
            "explanation": "Правильный порядок: подлежащее + глагол to be + прилагательное."
        },
        {
            "text": "Почему в английском нельзя «выкинуть» глагол из предложения?",
            "options": [
                "Потому что так красивее",
                "Потому что это разговорный стиль",
                "Потому что без глагола предложение не существует",
                "Потому что так делают только носители"
            ],
            "correct": 2,  # C
            "explanation": "Глагол — обязательный элемент английского предложения, без него предложение грамматически невозможно."
        },
        {
            "text": "Как правильно сказать «Холодно»?",
            "options": [
                "Cold",
                "Is cold",
                "It cold",
                "It is cold"
            ],
            "correct": 3,  # D
            "explanation": "Нужно использовать формальное подлежащее 'it' и глагол 'is': It is cold."
        },
        {
            "text": "Что обязательно должно быть в английском предложении, даже если по-русски этого нет?",
            "options": [
                "Артикль",
                "Предлог",
                "Глагол",
                "Наречие"
            ],
            "correct": 2,  # C
            "explanation": "Глагол обязателен в каждом английском предложении, даже если в русском переводе его нет."
        },
        {
            "text": "Как правильно сказать «Я работаю»?",
            "options": [
                "I working",
                "I am work",
                "I work",
                "Work I"
            ],
            "correct": 2,  # C
            "explanation": "В Present Simple используется базовая форма глагола: I work."
        },
        {
            "text": "Что означает мысль «английский — язык конструктора»?",
            "options": [
                "В нём много сложных правил",
                "Нужно угадывать формы слов",
                "Предложения собираются из чётких блоков",
                "Он подходит только для технических тем"
            ],
            "correct": 2,  # C
            "explanation": "Английский язык строится по чётким схемам, как конструктор из блоков."
        },
        {
            "text": "Как правильно задать вопрос «Ты работаешь?»?",
            "options": [
                "You work?",
                "Do you work?",
                "Work you?",
                "Are you work?"
            ],
            "correct": 1,  # B
            "explanation": "Для вопроса в Present Simple используется вспомогательный глагол 'do': Do you work?"
        },
        {
            "text": "Как правильно построить отрицание?",
            "options": [
                "I not work",
                "I no work",
                "I do not work",
                "I work not"
            ],
            "correct": 2,  # C
            "explanation": "Для отрицания в Present Simple используется 'do not' (don't): I do not work."
        }
    ]

    # Add questions
    for idx, q_data in enumerate(questions_data):
        question = Question(
            topic_id=topic.id,
            question_text=q_data["text"],
            correct_index=q_data["correct"],
            explanation=q_data["explanation"],
            display_order=idx
        )
        db.add(question)
        db.flush()

        # Add options
        for opt_idx, opt_text in enumerate(q_data["options"]):
            option = QuestionOption(
                question_id=question.id,
                option_text=opt_text,
                option_index=opt_idx
            )
            db.add(option)

    # Update topic total_questions
    topic.total_questions = len(questions_data)
    db.commit()

    print(f"✓ Added {len(questions_data)} quiz questions to the database")


def main():
    """Main update function"""
    print("=" * 60)
    print("Adding first quiz questions to database")
    print("=" * 60)

    db = SessionLocal()

    try:
        add_first_quiz(db)
        print("\n" + "=" * 60)
        print("✅ Successfully added first quiz questions!")
        print("=" * 60)

    except Exception as e:
        db.rollback()
        print(f"\n❌ Error: {e}")
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
