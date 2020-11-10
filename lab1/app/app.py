from random import randint
from flask import Flask, render_template, url_for
from faker import Faker

fake=Faker()

app = Flask(__name__)  
application = app

images_ids = ['4jh3k5h4-fk4k-l8ly-gkks-f7gjs83nf83j',
              'd8g88s3j-skak-33d1-d134-12vg4tqs5gs9',
              'f83j3igi-rj4n-fn41-412s-2kfnqkfj2hr3',
              '5k2k4n4k-5h31-gj48-skw4-3n4bnkb3l4b1',
              '54j2k2hb-r314-5315-qrq1-53f04o2jtj1j']

def generate_comments(replies=True):
    comments=[]
    for i in range (randint(1, 3)):
        comment = {'author' : fake.name(), 'text' : fake.text()}
        if replies:
            comment['replies'] = generate_comments(replies=False)
    return comments

def generate_post(i):
    return {
        'title':'Заголовок поста',
        'text': fake.paragraph(nb_sentences=100),
        'author' : fake.name(),
        'date': fake.date_time_between(start_date='-2y', end_date='now'),
        'image_filename' : f'{images_ids[i]}.jpg',
        'comments' : generate_comments()
    }

posts_list = [generate_post(i) for i in range(5) ]

@app.route('/')
def index():
    return render_template('index.html') 

@app.route('/posts')
def posts():
    title = 'Посты'
    return render_template('posts.html', title=title, posts=posts_list)

@app.route('/posts/<int:index>')
def post(index):
    p=posts_list[index]
    return render_template('post.html', title=p['title'], post=p)


@app.route('/about')
def about():
    title = 'Об авторе'
    return render_template('about.html', title=title)