"""Data models package."""

from .topic import TOPICS_DATA, get_all_topics, get_topic_by_id, get_topics_by_difficulty

__all__ = [
    "TOPICS_DATA",
    "get_all_topics",
    "get_topic_by_id",
    "get_topics_by_difficulty",
]
