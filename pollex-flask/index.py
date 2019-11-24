from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/auth', methods=['POST'])
def authenticate_user():
    if 'username' in request.json and 'password' in request.json:

    # TODO: verify user
        return jsonify(id=42, token="$2fr43Pv"), 200
    else:
        return jsonify({ "error": "expected a json with username and password" }), 400

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
