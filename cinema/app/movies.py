import os
import bleach
from flask import Blueprint, render_template, redirect, url_for, request, current_app, flash
from flask_login import login_required, current_user
from tools import Navigator, ImageSaver
from models import Genre, Movie

from app import db

bp = Blueprint('movies', __name__, url_prefix='/movies')


PARAMS_OF_MOVIE = ['name', 'year', 'country', 'producer', 'screenwriter', 'duration', 'description', 'actors']


def params():
    return { p: request.form.get(p) for p in PARAMS_OF_MOVIE }

@bp.route('/new')
def new():
    genres = Genre.query.all()
    return render_template('movies/new.html', genres=genres)


@bp.route('/create', methods=['POST'])
def create():
    f = request.files.get('background_img') 
    img = None
    if f and f.filename:
        img_saver = ImageSaver(f)
        img = img_saver.save()

    movie = Movie(**params(), poster_id=img.id)
    db.session.add(movie)
    db.session.commit()

    if img:
        img_saver.bind_to_object(movie)

    flash(f'Фильм {movie.name} был успешно создан!', 'success')

    return redirect('index')



    

