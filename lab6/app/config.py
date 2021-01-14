import os

SECRET_KEY = b'\xeal\xcf]\xfftx\xec\xadb\xd7\xa8S\xd4i\x82'

SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://std_1225:G28F03P01@std-mysql.ist.mospolytech.ru/std_1225'
# SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.path.dirname(os.path.abspath(__file__)), 'develop.db')
SQLALCHEMY_TRACK_MODIFICATIONS = False # чтобы не отслеживать все изменения, которые произошли с объектом, т.к. требуются на это ресурсы

UPLOAD_FOLDER = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), 
    'media/images'
)