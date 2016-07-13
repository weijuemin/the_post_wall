from flask import Flask, render_template, request, redirect, session, flash
from mysqlconnection import MySQLConnector
from flask_bcrypt import Bcrypt
import re
app = Flask(__name__)
app.secret_key = 'ThisIsASecretKey'
bcrypt = Bcrypt(app)
mysql = MySQLConnector(app, 'wall')
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/login', methods=['POST'])
def login(): # validation and log in
	session['email'] = request.form['email']
	email = request.form['email']
	password = request.form['password']
	error = 0
	if len(email) < 1:
		flash('Please enter email', 'email')
		error = 1
	elif not EMAIL_REGEX.match(email):
		flash('Invalid email address', 'email')	
		error = 2
	if len(password) <12:
		flash('Password must be more than 12 characters', 'password')
		error = 3
	if error != 0:
		return redirect('/')
	else:
		pw_hash = bcrypt.generate_password_hash(password)
		loginQuery = "SELECT * FROM users WHERE email = :email LIMIT 1"
		loginData = {'email': email}
		userSelected = mysql.query_db(loginQuery, loginData)
		user_name = "{} {}".format(userSelected[0]['first_name'], userSelected[0]['last_name'])
		if email==userSelected[0]['email'] and bcrypt.check_password_hash(userSelected[0]['password'], password):
			session.pop('email')
			session['user_id'] = userSelected[0]['id']
			session['full_name'] = user_name
			if 'fname' in session:
				session.pop('fname')
			if 'lname' in session:
				session.pop('lname')
			return redirect('/welcome')
		else:
			if email!=userSelected[0]['email']:
				flash("This email hasn't been registered","login")
			if password!=userSelected[0]['password']:
				flash("Incorrect password","login")
			return redirect('/')


@app.route('/register', methods=['POST'])
def create_user():
	session['fname'] = request.form['fname']
	session['lname'] = request.form['lname']
	session['email'] = request.form['email']
	fname = request.form['fname']
	lname = request.form['lname']
	email = request.form['email']
	password = request.form['password']
	passwordConf = request.form['passwordConf']
	checkExistEmail = mysql.query_db('SELECT email FROM users WHERE email = :email', {'email': email})
	error = 0
	if len(fname) < 1:
		flash('Please enter first name', 'fname')
		error = 1
	if len(lname) < 1:
		flash('Please enter last name', 'lname')
		error = 2
	if len(email) < 1:
		flash('Please enter email', 'email')
		error = 3
	elif not EMAIL_REGEX.match(email):
		flash('Invalid email address', 'email')	
		error = 4
	if checkExistEmail:
		flash('This email has already been registered','registered')
		error = 5
	if len(password) <12:
		flash('Password must be more than 12 characters', 'password')
		error = 6
	if password != passwordConf:
		flash('Password doesn\'t match','passwordConf')
		error = 7
	if error != 0:
		return redirect('/')
	else:
		pw_hash = bcrypt.generate_password_hash(password)
		regQuery = "INSERT into users (first_name, last_name, email, password, created_at, updated_at) VALUES (:fname, :lname, :email, :password, NOW(), NOW())"
		regData = {
			'fname': fname,
			'lname': lname,
			'email': email,
			'password': pw_hash,
		}
		mysql.query_db(regQuery, regData)
		userSelected = mysql.query_db('SELECT * FROM users WHERE email = :email LIMIT 1',{'email': email})
		user_name = "{} {}".format(userSelected[0]['first_name'], userSelected[0]['last_name'])
		session.pop('email')
		session.pop('fname')
		session.pop('lname')
		session['user_id'] = userSelected[0]['id']
		session['full_name'] = user_name
		return redirect('/welcome')

@app.route('/welcome') #user welcome page
def user_welcome():
	return render_template('user_welcome.html', user_name=session['full_name'])

@app.route('/wall')
def wall():
	postsQuery = "SELECT messages.message, CONCAT_WS(' ',users.first_name,users.last_name) AS full_name, DATE_FORMAT(messages.updated_at, '%W %h:%i %p, %m/%d') AS updated_time, messages.id AS message_id FROM messages JOIN users ON messages.user_id = users.id ORDER BY messages.updated_at DESC LIMIT 15"
	recentPosts = mysql.query_db(postsQuery)
	msgLength = len(recentPosts)
	getCmtQuery = "SELECT messages.id AS message_id, comments.comment, DATE_FORMAT(comments.updated_at, '%h:%i %p, %m/%d') AS comment_time, CONCAT_WS(' ', users.first_name, users.last_name) AS user_name FROM comments JOIN messages ON messages.id = comments.message_id JOIN users ON messages.user_id = users.id"
	getComments = mysql.query_db(getCmtQuery)
	cmtLength = len(getComments)
	return render_template('wall.html', user_name=session['full_name'], recentPosts=recentPosts, getComments=getComments, len=msgLength, lenCmt=cmtLength)

@app.route('/messages', methods=['POST'])
def wallPost():
	message = request.form['message']
	msgQuery = "INSERT into messages (message, created_at, updated_at, user_id) VALUES (:message, NOW(), NOW(), :user_id)"
	msgData = {
		'message': message,
		'user_id': session['user_id']
	}
	if len(message) < 1:
		flash('Cannot post empty message','msg')
	else:
		selfPost = mysql.query_db(msgQuery,msgData)
		return redirect('/wall')

# Comment part is not finished. Not know how to retrieve the comment's associated message content or message id

@app.route('/comments', methods=['POST'])
def postComment():
	comment = request.form['comment']
	cmtMsgId = request.form['commentGetMsgId']
	cmtQuery = "INSERT into comments (comment, created_at, updated_at, message_id, user_id) VALUES (:comment, NOW(), NOW(), :message_id, :user_id)"
	cmtData = {
		'comment': comment,
		'message_id': cmtMsgId,
		'user_id': session['user_id']
	}
	insertComments = mysql.query_db(cmtQuery, cmtData)
	return redirect('/wall')

app.run(debug=True)