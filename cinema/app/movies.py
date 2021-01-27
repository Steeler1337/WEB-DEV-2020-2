import os
import bleach
from flask import Blueprint, render_template, redirect, url_for, request, current_app, flash
from flask_login import login_required, current_user
from tools import ImageSaver
from models import Genre, Movie, Review, Movie_genre, Complitation, Complitation_movie

from app import db

bp = Blueprint('movies', __name__, url_prefix='/movies')

from app import check_rights

PARAMS_OF_MOVIE = ['name', 'year', 'country', 'producer', 'screenwriter', 'duration', 'description', 'actors']
PARAMS_OF_REVIEW = ['rating', 'text', 'movie_id', 'user_id']


def params():
    return { p: request.form.get(p) for p in PARAMS_OF_MOVIE }

def review_params():
    return { p: request.form.get(p) for p in PARAMS_OF_REVIEW }

@bp.route('/new')
@check_rights('new')
@login_required
def new():
    genres = Genre.query.all()
    return render_template('movies/new.html', genres=genres)


@bp.route('/create', methods=['POST'])
@check_rights('new')
@login_required
def create():
    f = request.files.get('background_img') 
    img = None
    if f and f.filename:
        img_saver = ImageSaver(f)
        img = img_saver.save()
    else:
        flash('Введены некорректные данные или не все поля заполнены. Ошибка сохранения', 'danger')
        return redirect(url_for('movies.new'))
    
    
    movie = Movie(**params(), poster_id=img.id)
    try:
        db.session.add(movie)
        db.session.commit()
    except:
        flash('Введены некорректные данные или не все поля заполнены. Ошибка сохранения', 'danger')
        return redirect(url_for('movies.new'))

    genres = request.form.getlist('genres')
    for genre in genres:
        movie_genres = Movie_genre(movie_id=movie.id, genre_id=genre)
        db.session.add(movie_genres)
        db.session.commit()


    if img:
        img_saver.bind_to_object(movie)

    flash(f'Фильм {movie.name} был успешно создан!', 'success')

    return redirect(url_for('index'))


@bp.route('/<int:movie_id>')
def show(movie_id): 
    movie = Movie.query.get(movie_id)
    reviews = Review.query.filter( Review.movie_id == movie_id )
    checker = False    
    if current_user.is_authenticated:
        for review in reviews:
            if review.user_id == current_user.id:
                checker = True
    complitations = Complitation.query.filter( Complitation.user_id == current_user.id)
    return render_template('movies/show_movie.html', movie=movie, reviews=reviews, checker=checker, complitations=complitations)


@bp.route('/review/<int:movie_id>', methods=['POST'])
@login_required
def review(movie_id):
    
    review = Review(**review_params())
    db.session.add(review)
    db.session.commit()
    flash('Ваша рецензия успешно сохранена!', 'success')
    return redirect(url_for("movies.show", movie_id=movie_id))

@bp.route('/<int:movie_id>/review')
@login_required
def review_generator(movie_id):
    reviews = Review.query.filter( Review.movie_id == movie_id )
    for review in reviews:
        if current_user.id == review.user_id:
            flash('Вы уже оставили рецензию.', 'warning')
            return redirect(url_for("movies.show", movie_id=movie_id))

    movie=Movie.query.get(movie_id)
    return render_template('movies/review.html', movie=movie)


@bp.route('/<int:movie_id>/edit')
@check_rights('edit')
@login_required
def edit(movie_id):   
    movie = Movie.query.get(movie_id)
    genres = Genre.query.all()
    movie_genres = Movie_genre.query.all()
    return render_template('movies/edit.html', movie=movie, genres=genres, movie_genres=movie_genres)
    

@bp.route('/<int:movie_id>/update', methods=['POST'])
@check_rights('edit')
@login_required
def update(movie_id):
    movie = Movie.query.get(movie_id)
    
    try:
        if len(request.form.get('name'))>0:
            movie.name = request.form.get('name')
        else:
            1/0

        description = bleach.clean(request.form.get('description')) 
        if len(description)>0:
            movie.description = description
        else:
            1/0

        movie.year = request.form.get('year') 

        if len(request.form.get('country'))>0:
            movie.country = request.form.get('country') 
        else:
            1/0

        if len(request.form.get('producer'))>0:
            movie.producer = request.form.get('producer') 
        else:
            1/0

        if len(request.form.get('screenwriter'))>0:
            movie.screenwriter = request.form.get('screenwriter') 
        else:
            1/0

        if len(request.form.get('actors'))>0:
            movie.actors = request.form.get('actors') 
        else:
            1/0
            
        movie.duration = request.form.get('duration')

        db.session.add(movie)
        db.session.commit()
    except:
        flash('Введены некорректные данные1. Ошибка сохранения', 'danger')
        return redirect(url_for('movies.edit', movie_id=movie_id))

    

    genres = request.form.getlist('genres')
    try:
        if len(genres) == 0:
            1/0
    except:
        flash('Введены некорректные данные2. Ошибка сохранения', 'danger')
        return redirect(url_for('movies.edit', movie_id=movie_id))

    previous_genres = Movie_genre.query.filter(Movie_genre.movie_id == movie_id)
    for prev_genre in previous_genres:
        db.session.delete(prev_genre)
        db.session.commit()
    for genre in genres:
        movie_genre = Movie_genre(movie_id=movie.id, genre_id=genre)
        db.session.add(movie_genre)
        db.session.commit()
    
    
    flash(f'Фильм {movie.name} был успешно обновлён.', 'success')
    return redirect(url_for('index'))


@bp.route('/<int:movie_id>/delete', methods=['POST'])
@check_rights('delete')
@login_required
def delete(movie_id):
    movie_genres = Movie_genre.query.filter(Movie_genre.movie_id == movie_id)
    for row in movie_genres:
        db.session.delete(row)
        db.session.commit()
    Movie.query.filter(Movie.id == movie_id).delete()
    db.session.commit()
    flash('Запись была успешно удалена!', 'success')
    return redirect(url_for('index'))

@bp.route('/user/<int:user_id>/complitations_list')
@login_required
def complitations_list(user_id):   
    complitations = Complitation.query.filter( Complitation.user_id == user_id)
    return render_template('movies/complitations_list.html', complitations=complitations, user_id=user_id)

@bp.route('/list_of_movies/<int:complitation_id>')
@login_required
def list_of_movies(complitation_id):
    movies = Movie.query.all()   
    complitation_movies = Complitation_movie.query.filter(Complitation_movie.comp_id == complitation_id)
    comp=Complitation.query.get(complitation_id)
    return render_template('movies/list_of_movies.html', complitation_movies=complitation_movies, movies=movies, comp=comp)


@bp.route('/user/<int:user_id>/new_comp', methods=['POST'])
@login_required
def new_comp(user_id):
    name=request.form.get('comp_name')
    comp=Complitation(name=name,
    user_id=user_id)
    try:
        db.session.add(comp)
        db.session.commit()
    except:
        flash('Возникла ошибка, повторите позже.', 'danger')
    flash(f'Подборка "{name}" была успешно добавлена!', 'success')
    return redirect(url_for('movies.complitations_list', user_id=user_id))

@bp.route('/add_to_comp/<int:movie_id>', methods=['POST'])
@login_required
def add_to_comp(movie_id):
    movie = Movie.query.get(movie_id)
    movie_name = movie.name
    comp_id = request.form.get('complitations')
    print(comp_id)
    comp = Complitation.query.get(comp_id)
    comp_name = comp.name
    comp_movies=Complitation_movie(comp_id=comp_id,
    movie_id=movie_id)
    try:
        db.session.add(comp_movies)
        db.session.commit()
    except:
        db.session.rollback()
        flash('Возникла ошибка, повторите позже.', 'danger')
    flash(f'Фильм "{movie_name}" был успешно добавлена в подборку "{comp_name}" !', 'success')
    return redirect(url_for('movies.show', movie_id=movie_id))