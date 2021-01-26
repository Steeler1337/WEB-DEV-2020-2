import os

SECRET_KEY = b'\xeal\xcf]\xfftx\xec\xadb\xd7\xa8S\xd4i\x82'

SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://std_1225:G28F03P01@std-mysql.ist.mospolytech.ru/std_1225'
# SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.path.dirname(os.path.abspath(__file__)), 'develop.db')
SQLALCHEMY_TRACK_MODIFICATIONS = False

UPLOAD_FOLDER = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), 
    'media/images'
)

#join(path1[, path2[, ...]]) - соединяет пути с учётом особенностей операционной системы.
#dirname(path) - возвращает имя директории пути path
#.abspath(path) - возвращает нормализованный абсолютный путь.
