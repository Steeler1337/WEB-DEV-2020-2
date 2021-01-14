from functools import wraps # чтобы сохранились __name__ и __doc__ у обёрнутой функции.
from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user
from app import mysql
from users_policy import UsersPolicy

bp = Blueprint('auth', __name__, url_prefix='/auth') # Blueprint - объект, в который можно написать набор функций, затем зарегать его в app.py. url_prefix будет у всех роутов, которые есть в blueprint .(__name__ чтобы знал где искать url_prefix).

class User(UserMixin):  # создали свой класс User, который унаследован от UserMixin. User принимает как аргумент user_id, login.
    def __init__(self, user_id, login, role_id): # именно user_id запоминается, как идентификатор пользователя. Поэтому и в load_user также передаётся user_id.
        super().__init__() # вызывает метод __init__ у родит. класса
        self.id = user_id 
        self.login = login # логин тоже уникальное поле, но для удобства ипользуем id.
        self.role_id = role_id
    
    def can(self, action, record=None): # action - название действий: edit, show, new, delete.
        policy = UsersPolicy(record=record)
        method = getattr(policy, action, None) # gettatr принимает объект, у которого мы хотим проверить наличие атрибута, и название атрибута. третий аргумент - что должна возвращать функция, если у объекта не нашлось такого атрибута.
        if method:
            return method() # если такой метод есть, он выполняется и возвращается true или false.
        return False # False, если мы не прописали права к соответствующему действию и запрещаем доступ.

def load_record(user_id):
    if user_id is None:
        return None
    cursor = mysql.connection.cursor(named_tuple=True) # cursor - специальный метод, который есть у объекта подключения для совершения sql-запросов с помощью метода execute
    cursor.execute('SELECT * FROM users2 WHERE id = %s;', (user_id,))
    record = cursor.fetchone()
    cursor.close()
    return record


def check_rights(action): # check_rights - возвращает декоратор 
    def decorator(func): # определяем сам декоратор (декоратор, т.к. в качестве аргумента принимает функцию)
        @wraps(func) # нужно, чтобы сохранились __name__ и __doc__ у обёрнутой функции.
        def wrapper(*args, **kwargs): # такие аргументы, т.к. мы не знаем заранее сколько их будет и будут ли они позиционными. Это функция обёртка
            record = load_record(kwargs.get('user_id')) 
            if not current_user.can(action, record=record):
                flash('У вас недостаточно прав для доступа к данной странице.', 'danger')
                return redirect(url_for('index'))
            return func(*args, **kwargs) # если юзер имеет права, то вызываем исходную функцию и передаём ей все аргументы, переданные в функцию обёртку
        return wrapper
    return decorator

# все атрибуты, заданные в User, можно использовать через объект current_user.


def load_user(user_id): # user_loader - это callback, который позволяет инициализировать объект текущего пользователя. Становится доступен current_user в base.html
    cursor = mysql.connection.cursor(named_tuple=True) # cursor - специальный метод, который есть у объекта подключения для совершения sql-запросов с помощью метода execute
    cursor.execute('SELECT * FROM users2 WHERE id = %s;', (user_id,))
    db_user = cursor.fetchone()
    cursor.close()
    if db_user:
        return User(user_id=db_user.id, login=db_user.login, role_id=db_user.role_id)
    return None

@bp.route('/login', methods=['GET', 'POST'])
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
                user = User(user_id=db_user.id, login=db_user.login, role_id=db_user.role_id) # если пользователь есть с такими логином и паролем, то создаётся объект класса user.
                login_user(user, remember=remember_me) # на любых будущих страницах будет установлена ​​переменная current_user для этого пользователя.передаём функции фласка "login_user" этот объект. Она запоминает данные пользователя в сессии(кладёт в зашифрованный куки).

                flash('Вы успешно аутентифицированы.', 'success') # работает поверх сессии, сообщение сохраняется в сессию. Требует ключ.

                next = request.args.get('next') # отправляет на страницу,на которую была совершена попытка входа без аутентификации

                return redirect(next or url_for('index')) # если был next, то на некст, если нет, то на индекс
        flash('Введены неверные логин и/или пароль.', 'danger')
    return render_template('login.html')

@bp.route('/logout')
def logout():
    logout_user() # удаляет данные текущего пользователя из объекта session
    return redirect(url_for('index'))


def init_login_manager(app): 
    login_manager = LoginManager()
    login_manager.init_app(app) # регистрируем логин-менеджер в приложении
    login_manager.login_view = 'auth.login' # указываем эндпоинт для страницы входа, если пользователь захочет пройти без аутентификации
    login_manager.login_message = 'Для доступа к данной странице необходимо пройти процедуру аутентификации.'
    login_manager.login_message_category = 'warning'
    login_manager.user_loader(load_user) # user_loader - callback, инициализирующий объект юзера на основе того, что мы получаем из нашего load_user'a.