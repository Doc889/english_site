#!/usr/bin/env python3
"""
Add Future Simple topic to the database
"""

import sys
import re
from pathlib import Path

# Add parent directory to path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy.orm import Session
from app.db.base import SessionLocal
from app.db.models import Topic, RuleSection, RuleExample, Question, QuestionOption


def parse_lesson_file(file_path):
    """Parse a lesson .txt file"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Find where quizzes start
    quiz_start = content.find('КВИЗ 1')

    if quiz_start == -1:
        theory_content = content
        quiz_content = ''
    else:
        theory_content = content[:quiz_start].strip()
        quiz_content = content[quiz_start:].strip()

    return theory_content, quiz_content


def parse_theory_sections(theory_content):
    """Parse theory into sections"""
    sections = []
    lines = theory_content.split('\n')

    i = 2  # Skip title
    current_section = None
    current_content = []
    current_examples = []
    prev_line_empty = False

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        if not stripped:
            prev_line_empty = True
            i += 1
            continue

        # Main section titles are standalone, come after blank line
        # Patterns: numbered sections like "1. Title", "Word (translation)", "Topic про...", etc.
        has_number_prefix = re.match(r'^\d+\.\s+', stripped)
        has_parentheses_translation = '(' in stripped and ')' in stripped and len(stripped) < 50
        has_keyword = (' / ' in stripped or 'про' in stripped.lower() or 'между' in stripped.lower() or
                      'ошибки' in stripped.lower() or 'главное' in stripped.lower() or
                      'структура' in stripped.lower() or 'конструкции' in stripped.lower() or
                      'что такое' in stripped.lower() or 'когда используем' in stripped.lower() or
                      'наречия времени' in stripped.lower() or 'will vs' in stripped.lower())

        is_section_title = (
            prev_line_empty and
            10 < len(stripped) < 100 and
            not stripped.startswith(('•', '✔', '❌', '💡', '-', 'I ', 'You ', 'He ', 'She ', 'We ', 'They ', 'It ', '1️⃣', '2️⃣', '3️⃣', 'Подлежащее', 'Формула:', 'Примеры:', 'Структура:')) and
            not stripped[0].islower() and
            '?' not in stripped and
            (has_keyword or has_parentheses_translation or has_number_prefix)
        )

        if is_section_title and len(sections) < 15:
            # Save previous section
            if current_section:
                sections.append({
                    'title': current_section,
                    'content': '\n'.join(current_content),
                    'examples': current_examples
                })

            # Start new section
            current_section = stripped
            current_content = []
            current_examples = []
        else:
            # Content or example
            if any(stripped.startswith(marker) for marker in ['•', '✔', '❌', '💡', '-', '→', '1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣', '6️⃣', '7️⃣', 'Формула:', 'Примеры:', 'Структура:']):
                current_examples.append(stripped)
            elif '—' in stripped or len(stripped) < 100 or stripped.startswith(('I ', 'You ', 'He ', 'She ', 'We ', 'They ', 'It ', 'Will ', 'Do ', 'Does ')):
                current_examples.append(stripped)
            else:
                current_content.append(stripped)

        prev_line_empty = False
        i += 1

    # Save last section
    if current_section:
        sections.append({
            'title': current_section,
            'content': '\n'.join(current_content),
            'examples': current_examples
        })

    return sections


def parse_quiz_questions(quiz_content):
    """Parse quiz questions from content"""
    questions = []
    quiz_blocks = re.split(r'КВИЗ \d+', quiz_content)

    quiz_set = 1
    for block in quiz_blocks:
        if not block.strip():
            continue

        # Split into individual questions
        question_blocks = block.strip().split('\n\n')

        for q_block in question_blocks:
            lines = q_block.strip().split('\n')
            if len(lines) < 2:
                continue

            question_text = lines[0].strip()

            # Parse options and correct answer
            options = []
            correct_letter = None

            for line in lines[1:]:
                line = line.strip()
                if not line:
                    continue

                # Check if this line has the answer marker
                if '✅' in line:
                    # Extract correct letter
                    correct_match = re.search(r'✅\s*([A-D])', line)
                    if correct_match:
                        correct_letter = correct_match.group(1)
                    # Remove the marker part
                    line = re.sub(r'✅.*$', '', line).strip()

                # Parse option (format: "A) text B) text C) text D) text")
                option_matches = re.findall(r'([A-D])\)\s*([^A-D✅]+?)(?=\s*[A-D]\)|$)', line)
                for letter, text in option_matches:
                    options.append((letter, text.strip()))

            # Convert correct letter to index
            if correct_letter and len(options) >= 3:
                letter_to_index = {'A': 0, 'B': 1, 'C': 2, 'D': 3}
                correct_index = letter_to_index.get(correct_letter, 0)

                # Sort options by letter to ensure correct order
                options.sort(key=lambda x: x[0])
                option_texts = [opt[1] for opt in options]

                questions.append({
                    'text': question_text,
                    'options': option_texts[:4],  # Take first 4 options
                    'correct_index': correct_index,
                    'quiz_set': quiz_set
                })

        quiz_set += 1

    return questions


def add_topic(db: Session):
    """Add Future Simple topic to database"""

    print("=" * 60)
    print("Adding Future Simple Topic")
    print("=" * 60)

    # Parse file
    file_path = Path(__file__).parent.parent / 'english_lessons' / 'future_simple.txt'
    print(f"Reading future_simple.txt...")

    theory_content, quiz_content = parse_lesson_file(file_path)
    sections_data = parse_theory_sections(theory_content)
    questions_data = parse_quiz_questions(quiz_content)

    print(f"Found {len(sections_data)} theory sections")
    print(f"Found {len(questions_data)} quiz questions")

    # Check if topic already exists
    existing_topic = db.query(Topic).filter(Topic.id == 'future_simple').first()
    if existing_topic:
        print("⚠️  Topic 'future_simple' already exists. Deleting old data...")
        # Delete old questions
        db.query(Question).filter(Question.topic_id == 'future_simple').delete()
        # Delete old rule sections
        db.query(RuleSection).filter(RuleSection.topic_id == 'future_simple').delete()
        # Delete topic
        db.delete(existing_topic)
        db.commit()

    # Create topic
    topic = Topic(
        id='future_simple',
        title='Future Simple (Will)',
        description='Будущее простое время — предсказания, обещания, спонтанные решения',
        difficulty='beginner',
        total_questions=len(questions_data),
        display_order=14  # After present_continuous
    )
    db.add(topic)
    db.commit()
    print(f"✓ Created topic: {topic.title}")

    # Add theory sections
    print("\nAdding theory sections...")
    for idx, section_data in enumerate(sections_data):
        section = RuleSection(
            topic_id=topic.id,
            title=section_data['title'],
            content=section_data.get('content', ''),
            display_order=idx
        )
        db.add(section)
        db.flush()

        # Add examples
        for ex_idx, example_text in enumerate(section_data.get('examples', [])):
            example = RuleExample(
                rule_section_id=section.id,
                example_text=example_text,
                display_order=ex_idx
            )
            db.add(example)

        print(f"  ✓ {section.title} ({len(section_data.get('examples', []))} examples)")

    db.commit()

    # Add quiz questions
    print("\nAdding quiz questions...")
    for idx, q_data in enumerate(questions_data):
        question = Question(
            topic_id=topic.id,
            question_text=q_data['text'],
            correct_index=q_data['correct_index'],
            explanation='',  # Empty explanation for now
            display_order=idx,
            quiz_set=q_data['quiz_set']
        )
        db.add(question)
        db.flush()

        # Add options
        for opt_idx, opt_text in enumerate(q_data['options']):
            option = QuestionOption(
                question_id=question.id,
                option_text=opt_text,
                option_index=opt_idx
            )
            db.add(option)

    db.commit()
    print(f"  ✓ Added {len(questions_data)} questions across {max(q['quiz_set'] for q in questions_data)} quizzes")

    print("\n" + "=" * 60)
    print("✅ FUTURE SIMPLE TOPIC ADDED SUCCESSFULLY!")
    print("=" * 60)


def main():
    """Main function"""
    db = SessionLocal()

    try:
        add_topic(db)
    except Exception as e:
        db.rollback()
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
