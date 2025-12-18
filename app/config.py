"""
Application Configuration

Centralized settings and configuration for the English Learning Platform API.
"""

from pydantic_settings import BaseSettings
from pathlib import Path


class Settings(BaseSettings):
    """Application settings."""

    # Application Info
    app_name: str = "English Learning Platform API"
    app_version: str = "1.0.0"
    app_description: str = "REST API for serving English grammar lessons, quizzes, and tracking progress"

    # Server Configuration
    host: str = "0.0.0.0"
    port: int = 8000
    debug: bool = True

    # Database Configuration
    database_url: str = "postgresql://localhost:5432/english_learning"

    # CORS Settings
    cors_origins: list[str] = ["*"]
    cors_credentials: bool = True
    cors_methods: list[str] = ["*"]
    cors_headers: list[str] = ["*"]

    # API Configuration
    api_prefix: str = "/api"
    docs_url: str = "/api/docs"
    redoc_url: str = "/api/redoc"

    # Content Paths
    topics_dir: Path = Path("topics")
    templates_dir: Path = Path(".")

    # Quiz Settings
    passing_score_percentage: int = 70
    questions_per_topic: int = 20

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


# Global settings instance
settings = Settings()
