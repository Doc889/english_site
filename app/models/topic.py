"""
Topic Data Models

In-memory topic data. In production, this would be replaced with database models.
"""

from app.schemas.topic import TopicInfo


# Topic database (in production, this would be in a real database)
TOPICS_DATA: dict[str, TopicInfo] = {
    "articles": TopicInfo(
        id="articles",
        title="Articles (A, An, The)",
        description="Master the tiny but mighty words that come before nouns!",
        difficulty="beginner",
        filename="articles.html",
        total_questions=20
    ),
    "present-simple": TopicInfo(
        id="present-simple",
        title="Present Simple Tense",
        description="The most used tense in English - talk about habits, facts, and things that are always true!",
        difficulty="beginner",
        filename="present-simple.html",
        total_questions=20
    ),
    "nouns-plural": TopicInfo(
        id="nouns-plural",
        title="Nouns - Singular & Plural",
        description="From one to many - learn how to make words talk about more than one thing!",
        difficulty="beginner",
        filename="nouns-plural.html",
        total_questions=20
    ),
    "personal-pronouns": TopicInfo(
        id="personal-pronouns",
        title="Personal Pronouns",
        description="Stop repeating names! Use these handy little words instead.",
        difficulty="beginner",
        filename="personal-pronouns.html",
        total_questions=20
    ),
    "to-be-present": TopicInfo(
        id="to-be-present",
        title="To Be - Present Simple",
        description="Am, is, are - the three most important words in English!",
        difficulty="beginner",
        filename="to-be-present.html",
        total_questions=20
    ),
    "past-simple-regular": TopicInfo(
        id="past-simple-regular",
        title="Past Simple - Regular Verbs",
        description="Talk about what happened yesterday, last week, or a million years ago!",
        difficulty="beginner",
        filename="past-simple-regular.html",
        total_questions=20
    ),
    "past-simple-irregular": TopicInfo(
        id="past-simple-irregular",
        title="Past Simple - Irregular Verbs",
        description="The rebels of English verbs - they don't follow the rules!",
        difficulty="beginner",
        filename="past-simple-irregular.html",
        total_questions=20
    ),
    "present-continuous": TopicInfo(
        id="present-continuous",
        title="Present Continuous",
        description="Talk about actions happening RIGHT NOW!",
        difficulty="beginner",
        filename="present-continuous.html",
        total_questions=20
    ),
    "can-cant": TopicInfo(
        id="can-cant",
        title="Can / Can't",
        description="Talk about ability, possibility, and permission!",
        difficulty="beginner",
        filename="can-cant.html",
        total_questions=20
    ),
    "possessive-adjectives": TopicInfo(
        id="possessive-adjectives",
        title="Possessive Adjectives",
        description="Show ownership - this is MY book, not YOUR book!",
        difficulty="beginner",
        filename="possessive-adjectives.html",
        total_questions=20
    ),
    "adverbs-frequency": TopicInfo(
        id="adverbs-frequency",
        title="Basic Adverbs of Frequency",
        description="How often? Always, usually, sometimes, or never!",
        difficulty="beginner",
        filename="adverbs-frequency.html",
        total_questions=20
    ),
    "alphabet-pronunciation": TopicInfo(
        id="alphabet-pronunciation",
        title="The Alphabet & Pronunciation",
        description="Learn English letters, basic sounds, and pronunciation rules",
        difficulty="beginner",
        filename="alphabet-pronunciation.html",
        total_questions=20
    ),
    "greetings-introductions": TopicInfo(
        id="greetings-introductions",
        title="Basic Greetings & Introductions",
        description="Hello, goodbye, introducing yourself and others",
        difficulty="beginner",
        filename="greetings-introductions.html",
        total_questions=20
    ),
    "basic-adjectives": TopicInfo(
        id="basic-adjectives",
        title="Basic Adjectives",
        description="Describing people, places, and things",
        difficulty="beginner",
        filename="basic-adjectives.html",
        total_questions=20
    ),
    "demonstratives": TopicInfo(
        id="demonstratives",
        title="Demonstratives",
        description="This, that, these, those - pointing words!",
        difficulty="beginner",
        filename="demonstratives.html",
        total_questions=20
    ),
    "simple-questions": TopicInfo(
        id="simple-questions",
        title="Simple Questions",
        description="Yes/No questions and basic Wh- questions",
        difficulty="beginner",
        filename="simple-questions.html",
        total_questions=20
    ),
    "numbers-counting": TopicInfo(
        id="numbers-counting",
        title="Numbers & Counting",
        description="Cardinal and ordinal numbers - count everything!",
        difficulty="beginner",
        filename="numbers-counting.html",
        total_questions=20
    ),
    "time-dates": TopicInfo(
        id="time-dates",
        title="Time & Dates",
        description="Telling time, days, months, years - master the calendar!",
        difficulty="beginner",
        filename="time-dates.html",
        total_questions=20
    ),
    "there-is-are": TopicInfo(
        id="there-is-are",
        title="There Is / There Are",
        description="Describing what exists or is available - point things out!",
        difficulty="beginner",
        filename="there-is-are.html",
        total_questions=20
    ),
    "prepositions-place": TopicInfo(
        id="prepositions-place",
        title="Prepositions of Place",
        description="In, on, at, under, between - where is everything?",
        difficulty="beginner",
        filename="prepositions-place.html",
        total_questions=20
    ),
}


def get_all_topics() -> list[TopicInfo]:
    """Get all available topics."""
    return list(TOPICS_DATA.values())


def get_topic_by_id(topic_id: str) -> TopicInfo | None:
    """Get a specific topic by ID."""
    return TOPICS_DATA.get(topic_id)


def get_topics_by_difficulty(difficulty: str) -> list[TopicInfo]:
    """Get topics filtered by difficulty."""
    return [
        topic for topic in TOPICS_DATA.values()
        if topic.difficulty.lower() == difficulty.lower()
    ]
