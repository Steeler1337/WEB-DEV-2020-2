from flask import Flask, render_template, request, session, redirect, url_for, flash
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from mysql_db import MySQL
import mysql.connector as connector

login_manager = LoginManager()

# зашифрованные данные сессии хранятся в cookie под названием session. 
# SECRET_KEY из config.py используется в куки с ключом session в виде значения.

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')

mysql = MySQL(app)

login_manager.init_app(app) # регистрируем логин-менеджер в приложении
login_manager.login_view = 'login' # указываем эндпоинт для страницы входа
login_manager.login_message = 'Для доступа к данной странице необходимо пройти процедуру аутентификации.'
login_manager.login_message_category = 'warning'

class User(UserMixin):  # создали свой класс User, который унаследован от UserMixin. User принимает как аргумент user_id, login.
    def __init__(self, user_id, login): # именно user_id запоминается, как идентификатор пользователя. Поэтому и в load_user также передаётся user_id.
        super().__init__() # вызывает метод __init__ у родит. класса
        self.id = user_id 
        self.login = login # логин тоже уникальное поле, но для удобства ипользуем id.

# все атрибуты, заданные в User, можно использовать через объект current_user.

@login_manager.user_loader # после отправки на сервер куки session для того, чтобы понять какой пользователь это сделал после аутентификации. 
def load_user(user_id): # user_loader - это callback, который позволяет инициализировать объект текущего пользователя. Становится доступен current_user в base.html
    cursor = mysql.connection.cursor(named_tuple=True) # cursor - специальный метод, который есть у объекта подключения для совершения sql-запросов с помощью метода execute
    cursor.execute('SELECT * FROM users2 WHERE id = %s;', (user_id,))
    db_user = cursor.fetchone()
    cursor.close()
    if db_user:
        return User(user_id=db_user.id, login=db_user.login)
    return None


def load_roles():
    cursor = mysql.connection.cursor(named_tuple=True)
    cursor.execute('SELECT id, name FROM roles2;')
    roles = cursor.fetchall()
    cursor.close()
    return roles

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        login = request.form.get('login')
        password = request.form.get('password')
        remember_me = request.form.get('remember_me') == 'on'
        if login and password:
            cursor = mysql.connection.cursor(named_tuple=True)
            cursor.execute('SELECT * FROM users2 WHERE login = %s AND password_hash = SHA2(%s, 256);', (login, password))
            db_user = cursor.fetchone()
            cursor.close()
            if db_user:
                user = User(user_id=db_user.id, login=db_user.login) # если пользователь есть с такими логином и паролем, то создаётся объект класса user.
                login_user(user, remember=remember_me) # передаём функции фласка "login_user" этот объект. Она запоминает данные пользователя в сессии(кладёт в зашифрованный куки)

                flash('Вы успешно аутентифицированы.', 'success') # работает поверх сессии, сообщение сохраняется в сессию. Требует ключ.

                next = request.args.get('next') # отправляет на страницу,на которую была совершена попытка входа без аутентификации

                return redirect(next or url_for('index')) # если был next, то на некст, если нет, то на индекс
        flash('Введены неверные логин и/или пароль.', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    logout_user() # удаляет данные текущего пользователя из объекта session
    return redirect(url_for('index'))

@app.route('/users')
def users():
    cursor = mysql.connection.cursor(named_tuple=True)
    cursor.execute('SELECT users2.*, roles2.name AS role_name FROM users2 LEFT OUTER JOIN roles2 ON users2.role_id = roles2.id;')
    users = cursor.fetchall()
    cursor.close()
    return render_template('users/index.html', users=users) # загружаем всех пользователей и рендерим страничку с ними.

@app.route('/users/<int:user_id>')
@login_required
def show(user_id):
    cursor = mysql.connection.cursor(named_tuple=True)
    cursor.execute('SELECT * FROM users2 WHERE id = %s;', (user_id,))
    user = cursor.fetchone()
    cursor.execute('SELECT * FROM roles2 WHERE id = %s;', (user.role_id,))
    role = cursor.fetchone()
    cursor.close()
    return render_template('users/show.html', user=user, role=role)

@app.route('/users/new') # страничка с формой для создания пользователя
@login_required
def new():
    return render_template('users/new.html', user={}, roles=load_roles()) # user передаётся так, потому что его нужно объявить, но данных о нём ещё нет. в roles будет передан список доступных ролей из функции, описанной выше.

@app.route('/users/<int:user_id>/edit')
@login_required
def edit(user_id):   
    cursor = mysql.connection.cursor(named_tuple=True)
    cursor.execute('SELECT * FROM users2 WHERE id = %s;', (user_id,))
    user = cursor.fetchone()
    cursor.close()
    return render_template('users/edit.html', user=user, roles=load_roles())

@app.route('/users/create', methods=['POST']) # функция для создания пользователя
@login_required
def create():
    login = request.form.get('login') or None
    password = request.form.get('password') or None
    last_name = request.form.get('last_name') or None
    first_name = request.form.get('first_name') or None 
    middle_name = request.form.get('middle_name') or None
    try:
        role_id = int(request.form.get('role_id'))
    except ValueError:
        role_id = None
    querry = '''
        INSERT INTO users2 (login, password_hash, first_name, last_name, middle_name, role_id)
        VALUES (%s, SHA2(%s, 256), %s, %s, %s, %s);
    '''
    cursor = mysql.connection.cursor(named_tuple=True)
    try:
        cursor.execute(querry, (login, password, first_name, last_name, middle_name, role_id))
    except connector.errors.DatabaseError as err:
        flash('Введены некорректные данные. Ошибка сохранения', 'danger')
        user = { # в случае ошибки подставим в форму данные, которые были введены, чтобы можно было изменить
            'login': login, 
            'password': password,
            'last_name': last_name,
            'first_name': first_name,
            'middle_name': middle_name,
            'role_id': role_id
        }
        return render_template('users/new.html', user=user, roles=load_roles())
    mysql.connection.commit()
    cursor.close()
    flash(f'Пользователь {login} был успешно создан.', 'success')
    return redirect(url_for('users')) # редирект нужен для того, чтобы не возникало сообщений о повторной отправке формы при обновлении страницы.

@app.route('/users/<int:user_id>/update', methods=['POST'])
@login_required
def update(user_id):
    login = request.form.get('login') or None
    first_name = request.form.get('first_name') or None
    last_name = request.form.get('last_name') or None 
    middle_name = request.form.get('middle_name') or None
    try:
        role_id = int(request.form.get('role_id'))
    except ValueError:
        role_id = None
    querry = '''
        UPDATE users2 SET login=%s, first_name=%s, last_name=%s,  middle_name=%s, role_id=%s
        WHERE id=%s;
    '''
    cursor = mysql.connection.cursor(named_tuple=True)
    try:
        cursor.execute(querry, (login, first_name, last_name, middle_name, role_id, user_id))
    except connector.errors.DatabaseError as err:
        flash('Введены некорректные данные. Ошибка сохранения', 'danger')
        user = {
            'id': user_id,
            'login': login,
            'last_name': last_name,
            'first_name': first_name,
            'middle_name': middle_name,
            'role_id': role_id
        }
        return render_template('users/edit.html', user=user, roles=load_roles())
    mysql.connection.commit()
    cursor.close()
    flash(f'Пользователь {login} был успешно обновлён.', 'success')
    return redirect(url_for('users'))

@app.route('/users/<int:user_id>/delete', methods=['POST'])
@login_required
def delete(user_id):
    with mysql.connection.cursor(named_tuple=True) as cursor:
        try:
            cursor.execute('DELETE FROM users2 WHERE id = %s;', (user_id,))
        except connector.errors.DatabaseError as err:
            flash('Не удалось удалить запись.', 'danger')
            return redirect(url_for('users'))
        mysql.connection.commit()
        flash('Запись была успешно удалена!.', 'success')
    return redirect(url_for('users'))