from flask import Blueprint, request, jsonify
from werkzeug import generate_password_hash, check_password_hash
import bcrypt, secrets

auth_module = Blueprint('auth', __name__, url_prefix='/auth')

EMAIL_RE = '^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$'



@auth_module.route('/sign_in', methods=['POST'])
def authenticate_user():
    try:
        email = request.json['email']
        password = request.json['password']

        # Checking for empty values.
        if not email or not email.strip():
            return jsonify({ "message": "Please, fill in your e-mail" }), 400
        if not password or not password.strip():
            return jsonify({ "message": "Please, fill in your password" }), 400

        # Encoding
        email = email.encode("utf-8")
        password = password.encode("utf-8")

        user = ? # TODO: Database user query.
        if not user:
            return jsonify({ "message": "E-mail or password incorrect" }), 401
        if not bcrypt.checkpw(password, user.password):
            return jsonify({ "message": "E-mail or password incorrect" }), 401

        session_token = secrets.token_hex()
        # TODO: Insert session_token and user into database auth sessions.

        return jsonify(id=42, token=session_token)
    except:
        return jsonify({ "message": "Expected a JSON with username and password" }), 400

@auth_module.route('/sign_up', methods=['POST'])
def register_user():
    try:
        email = request.json['email']
        name = request.json['name']
        nusp = request.json['nusp'] # Apenas usuários USP usarão o pollex?
        password = request.json['password']

        # Checking for empty values.
        if not name or not name.strip():
            return jsonify({ "message": "Please, fill in your name" }), 400
        if not email or not email.strip():
            return jsonify({ "message": "Please, fill in your e-mail" }), 400
        if not nusp or not nusp.strip():
            return jsonify({ "message": "Please, fill in your USP Number" }), 400
        if not password or not password.strip():
            return jsonify({ "message": "Please, fill in a new password" }), 400

        # Encoding
        name = name.encode("utf-8")
        email = email.encode("utf-8")
        nusp = nusp.encode("utf-8")
        password = password.encode("utf-8")

        # Checking values length.
        if len(password) < 6:
            return jsonify({ "message": "The new password needs to be at least 6 chars" }), 400

        # Checking for invalid values.
        if not re.search(EMAIL_RE, email):
            return jsonify({ "message": "E-mail not valid" }), 400
        if not re.search('^[0-9]+$', nusp):
            return jsonify({ "message": "USP Number not valid" }), 400
        if not (re.search('[a-zA-Z]+', password) and re.search('[0-9]+', password)):
           return jsonify({ "message": "USP Number must have at least one number" }), 400

        # Password secure hashing (December, 2019).
        password = bcrypt.hashpw(password, bcrypt.gensalt())

        # TODO: usuário já existe no BD? Se sim, informar mensagem de erro.
        # TODO: inserir novo usuário no BD.

        return jsonify({ "message": "You are now registered." }), 400

    except:
        return jsonify({ "message": "Expected a JSON with email, name, USP number and password" }), 400
