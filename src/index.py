# helloworld.py - A quick example

from flask import Flask
from flask import render_template

app = Flask(__name__)

# This is our index home page

@app.route('/')
def hello_world():
    return render_template("index.html")


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
