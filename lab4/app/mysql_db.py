import mysql.connector as connector
from flask import g # это класс, который является обёрткой глобального словаря, хранящий пары "ключ": "значение"

class MySQL:
    def __init__(self, app): 
        self.app = app # определяем атрибут app, чтобы брать из него конфиг
        self.app.teardown_request(self.teardown_request) # говорим о том, что нужно вызывать метод teardown_request всякий раз после конца обработки запроса

    @property
    def connection(self):  #метод, осуществляющий подключение
        if 'db' not in g:
            g.db = self.connect()
        return g.db 

    def connect(self):
        return connector.connect(**self.config)

    @property # декоратор, позволяющий использовать метод как свойство/атрибут через точку без скобок
    def config(self):
        return {
            'user': self.app.config['MYSQL_USER'], # self.app - берём данные из конфигурации приложения, которые запомнили в ините
            'password': self.app.config['MYSQL_PASSWORD'], # то, что в квадратных скобках - придумываем название параметра, которое будет в конфиге
            'host': self.app.config['MYSQL_HOST'],
            'database': self.app.config['MYSQL_DATABASE']
        }

    def teardown_request(self, exception=None):  # чтобы подключение закрывалось, когда мы заканчиваем обработку запроса
        db = g.pop('db', None) # пытаемся извлечь из g объект по ключу 'db', если его нет, значит не нужно закрывать соединение
        if db is not None:
            db.close()

