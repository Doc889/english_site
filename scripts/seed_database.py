#!/usr/bin/env python3
"""
Seed Database Script

Loads data from seed_data.json into PostgreSQL database.
"""

import json
import sys
from pathlib import Path

# Add parent directory to path to import app modules
sys.path.insert(0, str(Path(__file__).parent.parent))

from sqlalchemy.orm import Session
from app.db.base import SessionLocal, engine
from app.db.models import Topic, RuleSection, RuleExample, Question, QuestionOption


def seed_database():
    """Seed database with data from seed_data.json."""

    # Read seed data
    seed_file = Path(__file__).parent / "seed_data.json"
    print(f"📖 Reading seed data from {seed_file}...")

    with open(seed_file, 'r', encoding='utf-8') as f:
        seed_data = json.load(f)

    print(f"✓ Loaded seed data successfully\n")
    print(f"📊 Data to insert:")
    print(f"  - Topics: {len(seed_data['topics'])}")
    print(f"  - Rule Sections: {len(seed_data['rule_sections'])}")
    print(f"  - Rule Examples: {len(seed_data['rule_examples'])}")
    print(f"  - Questions: {len(seed_data['questions'])}")
    print(f"  - Question Options: {len(seed_data['question_options'])}\n")

    # Create database session
    db: Session = SessionLocal()

    try:
        print("🔄 Starting database seeding...\n")

        # 1. Insert Topics (no dependencies)
        print("1️⃣  Inserting topics...")
        topic_objects = [Topic(**topic_data) for topic_data in seed_data['topics']]
        db.bulk_save_objects(topic_objects)
        db.commit()
        print(f"   ✓ Inserted {len(topic_objects)} topics\n")

        # 2. Insert Rule Sections (depends on topics)
        print("2️⃣  Inserting rule sections...")
        rule_section_objects = [RuleSection(**rule_data) for rule_data in seed_data['rule_sections']]
        db.bulk_save_objects(rule_section_objects)
        db.commit()
        print(f"   ✓ Inserted {len(rule_section_objects)} rule sections\n")

        # 3. Insert Rule Examples (depends on rule_sections)
        print("3️⃣  Inserting rule examples...")
        rule_example_objects = [RuleExample(**example_data) for example_data in seed_data['rule_examples']]
        db.bulk_save_objects(rule_example_objects)
        db.commit()
        print(f"   ✓ Inserted {len(rule_example_objects)} rule examples\n")

        # 4. Insert Questions (depends on topics)
        print("4️⃣  Inserting questions...")
        question_objects = [Question(**question_data) for question_data in seed_data['questions']]
        db.bulk_save_objects(question_objects)
        db.commit()
        print(f"   ✓ Inserted {len(question_objects)} questions\n")

        # 5. Insert Question Options (depends on questions)
        print("5️⃣  Inserting question options...")
        option_objects = [QuestionOption(**option_data) for option_data in seed_data['question_options']]
        db.bulk_save_objects(option_objects)
        db.commit()
        print(f"   ✓ Inserted {len(option_objects)} question options\n")

        # Verify counts
        print("🔍 Verifying database contents...")
        topic_count = db.query(Topic).count()
        rule_section_count = db.query(RuleSection).count()
        rule_example_count = db.query(RuleExample).count()
        question_count = db.query(Question).count()
        option_count = db.query(QuestionOption).count()

        print(f"  - Topics in DB: {topic_count}")
        print(f"  - Rule Sections in DB: {rule_section_count}")
        print(f"  - Rule Examples in DB: {rule_example_count}")
        print(f"  - Questions in DB: {question_count}")
        print(f"  - Question Options in DB: {option_count}\n")

        # Check if counts match
        expected_counts = {
            "Topics": (topic_count, len(seed_data['topics'])),
            "Rule Sections": (rule_section_count, len(seed_data['rule_sections'])),
            "Rule Examples": (rule_example_count, len(seed_data['rule_examples'])),
            "Questions": (question_count, len(seed_data['questions'])),
            "Question Options": (option_count, len(seed_data['question_options']))
        }

        all_match = True
        for table_name, (actual, expected) in expected_counts.items():
            if actual != expected:
                print(f"❌ Mismatch in {table_name}: expected {expected}, got {actual}")
                all_match = False

        if all_match:
            print("✅ Database seeded successfully! All counts match.\n")
        else:
            print("⚠️  Database seeded but some counts don't match.\n")

    except Exception as e:
        print(f"\n❌ Error during seeding: {e}")
        db.rollback()
        raise
    finally:
        db.close()


def main():
    """Main execution function."""
    print("=" * 70)
    print("DATABASE SEEDING SCRIPT")
    print("=" * 70)
    print()

    # Test database connection
    try:
        connection = engine.connect()
        connection.close()
        print("✓ Database connection successful\n")
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        print("Please ensure PostgreSQL is running and the database exists.")
        sys.exit(1)

    # Run seeding
    seed_database()

    print("=" * 70)
    print("SEEDING COMPLETE")
    print("=" * 70)


if __name__ == "__main__":
    main()
