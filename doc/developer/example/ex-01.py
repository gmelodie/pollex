# Makefile - Build script for quick start flask tutorial
#
#    Copyright (c) 2019 - Open Source Competencer Center ICMC-USP
#
#    This file is part of Pollex.
#
#    Pollex is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Pollex is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# QUICK START
# 
# Pollex is based on Flask web framework, a lightweighted Web Server Gateway
# Interface (WSGI) written in Python. The project is designed as service-
# oriented application hosted in a Runtime Partition System (RPS), currently
# Docker system. This is a quick learn-by-example guide for new developers.


# Import Flask and initilize application (bolierplate)

from flask import Flask
from flask import render_template

app = Flask(__name__)

# The service will listen to (default) TCP port 8081.
# Each route tells what the service should respond when the corresponding
# URL is fectched by the web client over HTTP.

# This is our index home page

@app.route('/')
def hello_world():
    return '<h1>Hello World!</h1>'

# A static URL

@app.route('/about')
def about():
    return '<h1>About</h1><p>Hello world is just an example</p>'

# Using parts of URL as variable

@app.route('/hello/<user>')
def hello(user):
    return f"<h1>Hi {user}</h1>"

# Returning a web page (residing under ./templates)


@app.route('/home')
def home():
    return render_template("home.html")

# Treat part of the URL as a function argument

@app.route('/function/<foo>')
def function(foo):
    return render_template("function.html", arg=foo)

# Bolierplate code

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
