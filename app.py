from flask import Flask, render_template, request, redirect, url_for, session, flash, make_response, jsonify
from flask_mysqldb import MySQL
from flask_bcrypt import Bcrypt
import os
from werkzeug.utils import secure_filename 

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta'

# SQL CONFIG---------------------------------------------------------
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'sebas_r'
app.config['MYSQL_PASSWORD'] = 'lemonsharkswim'
app.config['MYSQL_DB'] = 'flask_login'

mysql = MySQL(app)
bcrypt = Bcrypt(app)
# UTIL CUSTOM FUNCTIONS---------------------------------------------------------

def add_no_cache_headers(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache" 
    response.headers["Expires"] = "0"
    return response

# RUTAS---------------------------------------------------------

@app.route('/')
def home():
    if 'username' in session:
        return redirect(url_for('index'))
    return redirect(url_for('login')) 

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM users WHERE username = %s', (username,))
        user = cur.fetchone()
        cur.close()
        

        if user and bcrypt.check_password_hash(user[2], password):
            session['username'] = username
            cur = mysql.connection.cursor()
            cur.execute("SELECT adminstatus FROM users WHERE username = %s", (username,))
            adminstatus_result = cur.fetchone()
            cur.close()

            # Chequear rol
            if adminstatus_result and adminstatus_result[0] == 1:
                return redirect(url_for('admin'))
            else: return redirect(url_for('index'))
        else:
            flash('Usuario o contraseña incorrectos')
            return redirect(url_for('login'))

    response = make_response(render_template('login.html'))
    return add_no_cache_headers(response)

@app.route('/regis', methods=['GET', 'POST'])
def regis():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        # Check si el usuario existe
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        existing_user = cur.fetchone()
        cur.close()

        if existing_user:
            # Usuario ya existe
            flash('El nombre de usuario ya existe. Por favor, elige otro.')
            return redirect(url_for('regis'))

        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO users (username, password) VALUES (%s, %s)', (username, hashed_password))
        mysql.connection.commit()
        cur.close()

        flash('Registro exitoso. Por favor, inicia sesión.')
        return redirect(url_for('login'))

    response = make_response(render_template('regis.html'))
    return add_no_cache_headers(response)

@app.route('/index')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT adminstatus FROM users WHERE username = %s", (session['username'],))
    adminstatus_result = cur.fetchone()
    cur.close()

    if adminstatus_result and adminstatus_result[0] == 1:
        return redirect(url_for('admin'))

    if 'username' not in session:
        return redirect(url_for('login')) 
    response = make_response(render_template('index.html'))
    return add_no_cache_headers(response)

@app.route('/productos_user')
def productos_user():

    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM productos")
    productos = cur.fetchall()
    cur.close()

    return render_template('productos-user.html', productos=productos)

# FUNCIONES DE ADMINISTRADOR ------------------------------------------------------

@app.route('/admin')
def admin():
    if 'username' not in session:
        return redirect(url_for('login'))
    response = make_response(render_template('admin.html'))
    return add_no_cache_headers(response)

@app.route('/users')
def user_list():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM users")
    users = cur.fetchall()
    cur.close()

    return render_template('users.html', users=users)

@app.route('/productos')
def productos():
    
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM productos")
    productos = cur.fetchall()
    cur.close()

    return render_template('productos.html', productos=productos)

@app.route('/productos/agregar', methods=['GET', 'POST'])
def agregar_producto():

    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        precio = float(request.form['precio'])
        stock = int(request.form['stock'])

        print(type(precio), precio)
        print(type(stock), stock)

        cur = mysql.connection.cursor()
        cur.execute(
            "INSERT INTO productos (nombre, descripcion, precio, stock) VALUES (%s, %s, %s, %s)",
            (nombre, descripcion, precio, stock)
        )
        mysql.connection.commit()
        cur.close()

        return redirect(url_for('productos'))

    return render_template('productos-agregar.html')


@app.route('/productos/editar/<int:id>', methods=['GET', 'POST'])
def editar_producto(id):

    cur = mysql.connection.cursor()
    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        precio = request.form['precio']
        stock = request.form['stock']

        cur.execute("""
            UPDATE productos SET nombre=%s, descripcion=%s, precio=%s, stock=%s WHERE id=%s
        """, (nombre, descripcion, precio, stock, id))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('productos'))

    cur.execute("SELECT * FROM productos WHERE id=%s", (id,))
    producto = cur.fetchone()
    cur.close()

    return render_template('productos-editar.html', producto=producto)


@app.route('/productos/eliminar/<int:id>')
def eliminar_producto(id):

    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM productos WHERE id=%s", (id,))
    mysql.connection.commit()
    cur.close()

    return redirect(url_for('productos'))



@app.route('/contact')
def contact():
    if 'username' not in session:
        return redirect(url_for('login'))
    response = make_response(render_template('contact.html'))
    return add_no_cache_headers(response)

@app.route('/more')
def more():
    if 'username' not in session:
        return redirect(url_for('login'))
    response = make_response(render_template('more.html'))
    return add_no_cache_headers(response)

@app.route('/logout')
def logout():
    session.pop('username', None)
    response = make_response(redirect(url_for('login')))
    return add_no_cache_headers(response)

@app.route('/users/editar/<int:id>', methods=['GET', 'POST'])
def editar_usuario(id):
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        adminstatus = request.form['adminstatus']

        if password:
            hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
            cur.execute("""
                UPDATE users SET username=%s, password=%s, adminstatus=%s WHERE id=%s
            """, (username, hashed_password, adminstatus, id))
        else:
            cur.execute("""
                UPDATE users SET username=%s, adminstatus=%s WHERE id=%s
            """, (username, adminstatus, id))

        mysql.connection.commit()
        cur.close()
        return redirect(url_for('user_list'))

    cur.execute("SELECT * FROM users WHERE id=%s", (id,))
    user = cur.fetchone()
    cur.close()

    return render_template('users-editar.html', user=user)


@app.route('/users/eliminar/<int:id>')
def eliminar_usuario(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM users WHERE id=%s", (id,))
    mysql.connection.commit()
    cur.close()

    return redirect(url_for('user_list'))

if __name__ == '__main__':
    app.run(debug=True)