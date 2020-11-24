from flask import Flask, render_template, request, make_response
import operator as op

app = Flask(__name__)
application = app

operations = ['+', '-', '*', '/']
operations_functions = {'+': op.add, '-': op.sub, '*': op.mul, '/':op.truediv}




@app.route('/')
def index():
    return render_template('index.html')

@app.route('/args')
def args():
    return render_template('args.html')

@app.route('/headers')
def headers():
    return render_template('headers.html')

@app.route('/cookies')
def cookies():
    resp = make_response(render_template('cookies.html'))
    if 'username' in request.cookies: #проверка, есть в словаре cookies ключ username
        resp.set_cookie('username', 'some name', expires=0)
    else: 
        resp.set_cookie('username', 'some name')
    return resp

@app.route('/form', methods=['GET', 'POST'])
def form():
    return render_template('form.html')

@app.route('/calc')
def calc():
    try:
        result=None
        error_msg = None
        op1 = float(request.args.get('operand1'))
        op2 = float(request.args.get('operand2'))
        operation = request.args.get('operation')
        f = operations_functions[request.args.get('operation')]
        result = f(op1, op2)
    except ValueError:
        error_msg = 'Пожалуйста, вводите только числа.'
    except ZeroDivisionError:
        error_msg = 'На ноль делить нельзя.'
    except KeyError:
        error_masg = 'Недопустимая операция.'
    except TypeError:
        error_masg = 'Попробуйте ещё раз.'
    return render_template('calc.html', operations=operations, result=result, error_msg=error_msg)


@app.route('/phone', methods=['POST', 'GET'])
def phone():
        error_msg = None
        if request.method == 'POST':
            phone = request.form['phone_number']
            phone = phone.replace(' ', '')
            phone = phone.replace('(', '')
            phone = phone.replace(')', '')
            phone = phone.replace('-', '')
            phone = phone.replace('.', '')
            if phone.startswith('+7'):
                phone = phone.replace('+7', '8')
                if len(phone) == 11:
                    for symbol in phone:
                        if not symbol.isdigit():
                            error_msg = error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. В номере телефона встречаются недопустимые символы." + "</div>"
                            return render_template('phone.html', error_msg=error_msg)
                        else:
                            result = phone[0] + '-' + phone[1] + phone[2] + phone[3] + '-' + phone[4] + phone[5] + phone[6] + '-' + phone[7] + phone[8] + '-' + phone[9] + phone[10]
                            return render_template('phone.html', result=result)

                else:
                    error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. Неверное количество цифр." + "</div>"
                    return render_template('phone.html', error_msg=error_msg)

            elif phone.startswith('8'):
                if len(phone) == 11:
                    for symbol in phone:
                        if not symbol.isdigit():
                            error_msg = error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. В номере телефона встречаются недопустимые символы." + "</div>"
                            return render_template('phone.html', error_msg=error_msg)
                        else:
                            result = phone[0] + '-' + phone[1] + phone[2] + phone[3] + '-' + phone[4] + phone[5] + phone[6] + '-' + phone[7] + phone[8] + '-' + phone[9] + phone[10]
                            return render_template('phone.html', result=result)

                else:
                    error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. Неверное количество цифр." + "</div>"
                    return render_template('phone.html', error_msg=error_msg)

            else:
                if len(phone) == 10:
                    for symbol in phone:
                        if not symbol.isdigit():
                            error_msg = error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. В номере телефона встречаются недопустимые символы." + "</div>"
                            return render_template('phone.html', error_msg=error_msg)
                        else:
                            result = '8' + '-' + phone[0] + phone[1] + phone[2] + '-' + phone[3] + phone[4] + phone[5] + '-' + phone[6] + phone[7] + '-' + phone[8] + phone[9]
                            return render_template('phone.html', result=result)
                else:
                    error_msg = "<div class='invalid-feedback'>" + "Недопустимый ввод. Неверное количество цифр." + "</div>"
                    return render_template('phone.html', error_msg=error_msg)
        else:
            return render_template('phone.html')
        








# @app.route('/calc')
# def calc():
#     try:
#         result=None
#         error_msg = None
#         op1 = float(request.args.get('operand1'))
#         op2 = float(request.args.get('operand2'))
#         operation = request.args.get('operation')
#         if operation == '+':
#             result = op1 + op2
#         elif operation == '-':
#             result = op1 - op2
#         elif operation == '*':
#             result = op1 * op2
#         elif operation == '/':
#             result = op1 / op2
#     except ValueError:
#         error_msg = 'Пожалуйста, вводите только числа.'
#     except ZeroDivisionError:
#         error_msg = 'На ноль делить нельзя'
#     return render_template('calc.html', operations=operations, result=result, error_msg=error_msg)