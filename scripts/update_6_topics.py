#!/usr/bin/env python3
"""
Update the 6 newest topics with content from .txt files
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
        is_section_title = (
            prev_line_empty and
            10 < len(stripped) < 60 and
            not stripped.startswith(('•', '✔', '❌', '💡', '-', 'I ', 'You ', 'He ', 'She ', 'We ', 'They ', 'It ', '1️⃣', '2️⃣', '3️⃣')) and
            not stripped[0].islower() and
            '—' not in stripped and
            not stripped.endswith('.') and
            not stripped.endswith(':') and
            not stripped.endswith(')') and
            '?' not in stripped and
            (' / ' in stripped or 'про' in stripped.lower() or 'между' in stripped.lower() or 'ошибки' in stripped.lower() or 'главное' in stripped.lower())
        )

        if is_section_title and len(sections) < 10:
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
            if any(stripped.startswith(marker) for marker in ['•', '✔', '❌', '💡', '-', '→', '1️⃣', '2️⃣', '3️⃣', '4️⃣', '5️⃣']):
                current_examples.append(stripped)
            elif '—' in stripped or len(stripped) < 100:
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


def update_topic(db: Session, topic_id, txt_file):
    """Update a topic with content from .txt file"""

    print(f"\n{'='*60}")
    print(f"Updating '{topic_id}'")
    print(f"{'='*60}")

    # Parse file
    file_path = Path(__file__).parent.parent / 'english_lessons' / txt_file
    print(f"Reading {txt_file}...")

    theory_content, quiz_content = parse_lesson_file(file_path)
    sections_data = parse_theory_sections(theory_content)

    print(f"Found {len(sections_data)} theory sections")

    # Get topic
    topic = db.query(Topic).filter(Topic.id == topic_id).first()
    if not topic:
        print(f"❌ Topic '{topic_id}' not found in database!")
        return

    # Delete old rule sections
    db.query(RuleSection).filter(RuleSection.topic_id == topic_id).delete()
    db.commit()
    print(f"✓ Deleted old rule sections")

    # Add new theory sections
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
    print(f"✅ Topic '{topic_id}' updated successfully!")


def main():
    """Main function"""
    print("=" * 60)
    print("Updating 6 Topics with Content from .txt Files")
    print("=" * 60)

    db = SessionLocal()

    try:
        topics = [
            ('modal_verbs', 'modal_verbs.txt'),
            ('there_is_are', 'there_is_are.txt'),
            ('prepositions_place', 'prepositions_place.txt'),
            ('question_words', 'question_words.txt'),
            ('numbers_dates_time', 'numbers_dates_time.txt'),
            ('present_continuous', 'present_continuous.txt'),
        ]

        for topic_id, txt_file in topics:
            update_topic(db, topic_id, txt_file)

        print("\n" + "=" * 60)
        print("✅ ALL 6 TOPICS UPDATED SUCCESSFULLY!")
        print("=" * 60)

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
