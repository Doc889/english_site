#!/usr/bin/env python3
"""
Add first lesson content to the database
"""

import sys
from pathlib import Path

# Add parent directory to path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy.orm import Session
from app.db.base import SessionLocal
from app.db.models import Topic, RuleSection, RuleExample

def add_first_lesson_content(db: Session):
    """Add the first lesson content from first_lesson.txt"""

    topic = db.query(Topic).filter(Topic.id == "alphabet-pronunciation").first()
    if not topic:
        print("⚠️  First topic not found")
        return

    # Clear existing rules and examples
    for rule in db.query(RuleSection).filter(RuleSection.topic_id == topic.id).all():
        db.query(RuleExample).filter(RuleExample.rule_section_id == rule.id).delete()
    db.query(RuleSection).filter(RuleSection.topic_id == topic.id).delete()
    db.commit()

    # Section 1: Introduction
    rule1 = RuleSection(
        topic_id=topic.id,
        title="Давай сразу договоримся об одной вещи",
        content="Английский не сложный. Он просто не русский. И почти все проблемы начинаются ровно в тот момент, когда ты пытаешься обращаться с английским так, как привык с русским: переставлять слова как хочется, додумывать формы, переводить предложение «по смыслу». Английский так не работает. Зато он работает логично. И если ты поймёшь эту логику сейчас — дальше будет реально легко.",
        display_order=0
    )
    db.add(rule1)
    db.flush()

    # Section 2: English is a language of structure
    rule2 = RuleSection(
        topic_id=topic.id,
        title="Английский — это язык структуры",
        content="В русском языке смысл часто живёт в окончаниях. Мы можем менять слова местами, играться формами — и всё равно друг друга понимать. В английском всё держится на другом. Там смысл создаётся порядком слов. Есть чёткий скелет, и если ты его соблюдаешь — предложение работает. Если нет — разваливается, как бы правильно ни были выбраны слова.",
        display_order=1
    )
    db.add(rule2)
    db.flush()

    examples2 = [
        "кто → что делает → всё остальное",
        "I work here.",
        "She likes coffee.",
        "They live in London.",
    ]
    for idx, text in enumerate(examples2):
        db.add(RuleExample(rule_section_id=rule2.id, example_text=text, display_order=idx))

    # Section 3: Why you can't speak like Russian
    rule3 = RuleSection(
        topic_id=topic.id,
        title="Почему в английском нельзя говорить «как по-русски»",
        content="По-русски мы спокойно говорим: «Я студент», «Я дома», «Холодно». В английском такие предложения просто не существуют. Там нельзя оставить фразу без глагола. Никогда. Поэтому появляется то, чего мы не привыкли замечать: глагол to be, который в русском чаще всего «прячется», а в английском — выходит на сцену.",
        display_order=2
    )
    db.add(rule3)
    db.flush()

    examples3 = [
        "I am a student. (не просто 'student')",
        "I am at home. (не просто 'at home')",
        "It is cold. (не просто 'cold')",
    ]
    for idx, text in enumerate(examples3):
        db.add(RuleExample(rule_section_id=rule3.id, example_text=text, display_order=idx))

    # Section 4: The verb is everything
    rule4 = RuleSection(
        topic_id=topic.id,
        title="Если коротко: глагол — это всё",
        content="Если очень сильно упростить английский язык, получится одна мысль: вся грамматика крутится вокруг глаголов. Времена — это про глаголы. Вопросы — это про глаголы. Отрицания — это тоже глаголы. Даже когда кажется, что «действия нет», глагол всё равно есть. Просто он означает не действие, а состояние.",
        display_order=3
    )
    db.add(rule4)
    db.flush()

    # Section 5: Minimum required
    rule5 = RuleSection(
        topic_id=topic.id,
        title="Минимум, без которого предложение не живёт",
        content="Чтобы английское предложение вообще считалось предложением, ему нужны две вещи: Кто-то. И то, что с ним происходит — или кем он является. Всё. Даже это уже полноценные, правильные предложения. Убери одну часть — и фраза перестаёт существовать.",
        display_order=4
    )
    db.add(rule5)
    db.flush()

    examples5 = [
        "I work.",
        "She is tired.",
        "It is cold.",
    ]
    for idx, text in enumerate(examples5):
        db.add(RuleExample(rule_section_id=rule5.id, example_text=text, display_order=idx))

    # Section 6: The verb "to be"
    rule6 = RuleSection(
        topic_id=topic.id,
        title="Фундамент: глагол to be",
        content="Глагол to be — это не просто ещё один глагол. Это фундамент. Он нужен, когда ты: говоришь, кто ты; где ты; в каком ты состоянии; какой ты. И у него есть формы, которые просто надо принять как есть. Без философии. Без «почему так». Просто так устроен язык.",
        display_order=5
    )
    db.add(rule6)
    db.flush()

    examples6 = [
        "I am",
        "You are",
        "He / She / It is",
        "We / They are",
    ]
    for idx, text in enumerate(examples6):
        db.add(RuleExample(rule_section_id=rule6.id, example_text=text, display_order=idx))

    # Section 7: Why you can't say just "student"
    rule7 = RuleSection(
        topic_id=topic.id,
        title="Почему нельзя сказать просто «student»",
        content="Это один из самых частых ступоров. Почему нельзя сказать просто: student, doctor, work? Потому что английский не любит недосказанность. Ему важно, кто это и что именно происходит. Не потому что «так красивее», а потому что иначе язык не работает.",
        display_order=6
    )
    db.add(rule7)
    db.flush()

    examples7 = [
        "I am a student. (не просто 'student')",
        "She is a doctor. (не просто 'doctor')",
        "I work here. (не просто 'work')",
    ]
    for idx, text in enumerate(examples7):
        db.add(RuleExample(rule_section_id=rule7.id, example_text=text, display_order=idx))

    # Section 8: English is a constructor
    rule8 = RuleSection(
        topic_id=topic.id,
        title="Английский — это конструктор, а не угадайка",
        content="Хорошая новость: тебе не нужно чувствовать язык интуитивно, чтобы начать говорить правильно. Ты просто собираешь предложение из блоков. Подлежащее. Глагол. Дополнение. Ты не переводишь. Ты не подбираешь «похожее». Ты просто собираешь конструкцию. И это одна из самых сильных сторон английского языка.",
        display_order=7
    )
    db.add(rule8)
    db.flush()

    examples8 = [
        "I am learning English.",
    ]
    for idx, text in enumerate(examples8):
        db.add(RuleExample(rule_section_id=rule8.id, example_text=text, display_order=idx))

    # Section 9: Questions and negations
    rule9 = RuleSection(
        topic_id=topic.id,
        title="Вопросы и отрицания — тоже по схеме",
        content="В русском вопрос — это интонация. В английском — это структура. Появляются вспомогательные глаголы, меняется порядок слов — и всё, вопрос готов. То же самое с отрицаниями. Нельзя просто вставить «not» куда хочется. Это не «исключения». Это система. И она повторяется снова и снова.",
        display_order=8
    )
    db.add(rule9)
    db.flush()

    examples9 = [
        "I do not work.",
        "She is not ready.",
    ]
    for idx, text in enumerate(examples9):
        db.add(RuleExample(rule_section_id=rule9.id, example_text=text, display_order=idx))

    # Section 10: The most important mindset shift
    rule10 = RuleSection(
        topic_id=topic.id,
        title="Самая важная смена мышления",
        content="Пока ты думаешь: «Как это перевести с русского?» — будет тяжело. Как только ты начинаешь думать: «Какую структуру я сейчас использую?» — всё встаёт на места. Английский не переводят. Им оперируют.",
        display_order=9
    )
    db.add(rule10)
    db.flush()

    # Section 11: Main takeaway
    rule11 = RuleSection(
        topic_id=topic.id,
        title="Если вынести одну главную мысль",
        content="Английский — это не хаос правил. Это система повторяющихся моделей. И ты только что познакомился с самой базовой из них. Дальше будет: проще, логичнее, и, что важно, гораздо интереснее. Потому что фундамент у тебя уже есть.",
        display_order=10
    )
    db.add(rule11)
    db.flush()

    db.commit()
    print("✓ Added first lesson content to the database")


def main():
    """Main update function"""
    print("=" * 60)
    print("Adding first lesson content to database")
    print("=" * 60)

    db = SessionLocal()

    try:
        add_first_lesson_content(db)
        print("\n" + "=" * 60)
        print("✅ Successfully added first lesson content!")
        print("=" * 60)

    except Exception as e:
        db.rollback()
        print(f"\n❌ Error: {e}")
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
