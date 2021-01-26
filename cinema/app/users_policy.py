from flask_login import current_user 

ADMIN_ROLE_ID = 1
MODERATOR_ROLE_ID = 2
DEFAULT_ROLE_ID = 3


def is_admin():
    return current_user.role_id == ADMIN_ROLE_ID

def is_moderator():
    return current_user.role_id == MODERATOR_ROLE_ID

def is_default_user():
    return current_user.role_id == DEFAULT_ROLE_ID

class UsersPolicy: 
    def __init__(self, role_id): 
        self.role_id = role_id

    def edit(self):
        return is_admin() or is_moderator()

    def new(self):
        return is_admin()

    def delete(self):
        return is_admin()