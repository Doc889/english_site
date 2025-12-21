"""add quiz_set to questions

Revision ID: 4b86b53d9170
Revises: 1fc96f52bb66
Create Date: 2025-12-21 18:06:21.382772

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '4b86b53d9170'
down_revision: Union[str, Sequence[str], None] = '1fc96f52bb66'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Add quiz_set column with default value of 1
    op.add_column('questions', sa.Column('quiz_set', sa.Integer(), nullable=False, server_default='1'))


def downgrade() -> None:
    """Downgrade schema."""
    # Remove quiz_set column
    op.drop_column('questions', 'quiz_set')
