from flask_login import current_user # нужно, чтобы работать с понятием "текущий аутентифицированный пользователь"

ADMIN_ROLE_ID = 1
MODERATOR_ROLE_ID = 2


def is_admin():
    return current_user.role_id == ADMIN_ROLE_ID

def is_moderator():
    return current_user.role_id == MODERATOR_ROLE_ID

class UsersPolicy: # класс, имеющий набор методов, которые возвращают true или false в зависимости от прав пользователя.
    def __init__(self, record=None): # т.к. создание записи не требует сведений о конкретной записи, а редакт, просмотр и удаление - да, то делаем необязательный аргумент "record". 
        self.record = record # сохраняем эту запись в качестве атрибута для объекта класса UsersPolicy

    def edit(self):
        is_editing_user = current_user.id == self.record.id
        return is_admin() or is_editing_user

    def show(self):
        is_showing_user = current_user.id == self.record.id
        return is_admin() or is_showing_user

    def new(self):
        return is_admin()

    def delete(self):
        return is_admin()