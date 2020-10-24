from flask import Flask, render_template, url_for

app = Flask(__name__)  
application = app

@app.route('/')
def index():
    msg = 'Hello'
    return render_template('index.html', msg=msg) #передаём параметр msg и в качестве значения передадим значение этой переменной

@app.route('/posts')
def posts():
    return render_template('posts.html')

@app.route('/about')
def about():
    return render_template('about.html')