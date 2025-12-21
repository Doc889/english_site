"""
SQLAlchemy Database Models

Defines the database schema for the English Learning Platform.
"""

from sqlalchemy import Column, Integer, String, Text, ForeignKey, CheckConstraint, DateTime
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.db.base import Base


class Topic(Base):
    """Topics table - stores grammar topic metadata."""

    __tablename__ = "topics"

    id = Column(String(100), primary_key=True)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    difficulty = Column(
        String(50),
        nullable=False,
        index=True
    )
    total_questions = Column(Integer, nullable=False, default=20)
    display_order = Column(Integer, nullable=False, default=0, index=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    # Relationships
    rule_sections = relationship(
        "RuleSection",
        back_populates="topic",
        cascade="all, delete-orphan",
        order_by="RuleSection.display_order"
    )
    questions = relationship(
        "Question",
        back_populates="topic",
        cascade="all, delete-orphan",
        order_by="Question.display_order"
    )

    # Table constraints
    __table_args__ = (
        CheckConstraint(
            "difficulty IN ('beginner', 'intermediate', 'advanced')",
            name="check_difficulty"
        ),
    )

    def __repr__(self):
        return f"<Topic(id='{self.id}', title='{self.title}')>"


class RuleSection(Base):
    """Rule sections table - stores grammar rules for each topic."""

    __tablename__ = "rule_sections"

    id = Column(Integer, primary_key=True, autoincrement=True)
    topic_id = Column(
        String(100),
        ForeignKey("topics.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    title = Column(String(255), nullable=False)
    content = Column(Text, nullable=False)
    display_order = Column(Integer, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    topic = relationship("Topic", back_populates="rule_sections")
    examples = relationship(
        "RuleExample",
        back_populates="rule_section",
        cascade="all, delete-orphan",
        order_by="RuleExample.display_order"
    )

    # Unique constraint
    __table_args__ = (
        CheckConstraint("display_order >= 0", name="check_rule_order"),
    )

    def __repr__(self):
        return f"<RuleSection(id={self.id}, topic_id='{self.topic_id}', title='{self.title}')>"


class RuleExample(Base):
    """Rule examples table - stores example sentences for each rule."""

    __tablename__ = "rule_examples"

    id = Column(Integer, primary_key=True, autoincrement=True)
    rule_section_id = Column(
        Integer,
        ForeignKey("rule_sections.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    example_text = Column(Text, nullable=False)
    display_order = Column(Integer, nullable=False)

    # Relationships
    rule_section = relationship("RuleSection", back_populates="examples")

    # Constraints
    __table_args__ = (
        CheckConstraint("display_order >= 0", name="check_example_order"),
    )

    def __repr__(self):
        return f"<RuleExample(id={self.id}, rule_section_id={self.rule_section_id})>"


class Question(Base):
    """Questions table - stores quiz questions for each topic."""

    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, autoincrement=True)
    topic_id = Column(
        String(100),
        ForeignKey("topics.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    question_text = Column(Text, nullable=False)
    correct_index = Column(Integer, nullable=False)
    explanation = Column(Text, nullable=False)
    display_order = Column(Integer, nullable=False)
    quiz_set = Column(Integer, nullable=False, default=1)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    # Relationships
    topic = relationship("Topic", back_populates="questions")
    options = relationship(
        "QuestionOption",
        back_populates="question",
        cascade="all, delete-orphan",
        order_by="QuestionOption.option_index"
    )

    # Constraints
    __table_args__ = (
        CheckConstraint("correct_index >= 0 AND correct_index <= 3", name="check_correct_index"),
        CheckConstraint("display_order >= 0", name="check_question_order"),
    )

    def __repr__(self):
        return f"<Question(id={self.id}, topic_id='{self.topic_id}')>"


class QuestionOption(Base):
    """Question options table - stores 4 answer choices for each question."""

    __tablename__ = "question_options"

    id = Column(Integer, primary_key=True, autoincrement=True)
    question_id = Column(
        Integer,
        ForeignKey("questions.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )
    option_text = Column(String(500), nullable=False)
    option_index = Column(Integer, nullable=False)

    # Relationships
    question = relationship("Question", back_populates="options")

    # Constraints
    __table_args__ = (
        CheckConstraint("option_index >= 0 AND option_index <= 3", name="check_option_index"),
    )

    def __repr__(self):
        return f"<QuestionOption(id={self.id}, question_id={self.question_id}, option_index={self.option_index})>"
