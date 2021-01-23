import os
from flask import Flask, render_template, abort, send_from_directory
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import MetaData
from flask_migrate import Migrate

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

naming_convention = {
    'pk': 'pk_%(table_name)s',
    'fk': 'fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s',
    'ix': 'ix_%(table_name)s_%(column_0_name)s',
    'uq': 'uq_%(table_name)s_%(column_0_name)s',
    'ck': 'ck_%(table_name)s_%(constraint_name)s',
}

db = SQLAlchemy(app, metadata=MetaData(naming_convention=naming_convention))
migrate = Migrate(app, db)

from models import Poster, Movie, Review, Genre

from auth import bp as auth_bp, init_login_manager
from api import bp as api_bp
from movies import bp as movies_bp

init_login_manager(app)

app.register_blueprint(auth_bp)
app.register_blueprint(api_bp)
app.register_blueprint(movies_bp)

@app.route('/')
def index():
    movies = Movie.query.all()
    return render_template('index.html', movies=movies)

@app.route('/images/<poster_id>')
def image(poster_id):
    img = Poster.query.get(poster_id)
    if img is None:
        abort(404)
    return send_from_directory(app.config['UPLOAD_FOLDER'], img.storage_filename)
    