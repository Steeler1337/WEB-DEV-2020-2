"""complitations

Revision ID: 54778e45c018
Revises: de5051b9d9cd
Create Date: 2021-01-26 20:04:01.808095

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '54778e45c018'
down_revision = 'de5051b9d9cd'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('complitations',
    sa.Column('id', sa.Integer(), nullable=False),
    sa.Column('name', sa.String(length=100), nullable=False),
    sa.Column('user_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], name=op.f('fk_complitations_user_id_users')),
    sa.PrimaryKeyConstraint('id', name=op.f('pk_complitations'))
    )
    op.create_table('complitation_movies',
    sa.Column('comp_id', sa.Integer(), nullable=False),
    sa.Column('movie_id', sa.Integer(), nullable=False),
    sa.ForeignKeyConstraint(['comp_id'], ['complitations.id'], name=op.f('fk_complitation_movies_comp_id_complitations')),
    sa.ForeignKeyConstraint(['movie_id'], ['movies.id'], name=op.f('fk_complitation_movies_movie_id_movies')),
    sa.PrimaryKeyConstraint('comp_id', 'movie_id', name=op.f('pk_complitation_movies'))
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('complitation_movies')
    op.drop_table('complitations')
    # ### end Alembic commands ###
