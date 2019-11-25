from flask import Flask
from os import getenv
# Include SQLAlchemy here

app = Flask(__name__, instance_relative_config=True)

app.config.from_object('config.default')
if getenv('FLASK_ENV') == 'production': app.config.from_object('config.production')
if getenv('FLASK_ENV') == 'development': app.config.from_object('config.development')
app.config.from_pyfile('config.py')

# Import modules
from app.views.auth import auth_module

# Register Blueprints
app.register_blueprint(auth_module)
