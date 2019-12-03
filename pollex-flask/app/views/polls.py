from flask import Blueprint, request, jsonify

polls_module = Blueprint('polls', __name__, url_prefix='/polls')

@polls_module.route('', methods=['GET'])
def get_polls():
    try:
        token = request.json['token']

        return jsonify({"polls": [
            {
                "poll_id": 0,
                "name": "test poll",
                "poll_owner": "a",
                "votes_number": 3,
                "total_votes": 5,
                "created_date": "2019-11-21"
            },
            {
                "poll_id": 1,
                "name": "test poll 2",
                "poll_owner": "ba",
                "votes_number": 2,
                "total_votes": 15,
                "created_date": "2011-01-01"
            },
        ]})

    except:
        return jsonify({"message": "expected a json with token"}), 400
