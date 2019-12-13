# Pollex Flask API

## File structure
```
pollex-flask
├── ...                 # other files (Dockerfile, Makefile, etc.)
├── run.py              # execute this to run the application
├── app/
│   ├── __init__.py     # contains the general setup for the application
│   └── views/          # this is where all the routes are defined
│       ├── auth.py
│       └── ...
│
├── config/             # contains all configuration files
│   ├── __init__.py
│   ├── default.py      # always loads default config
│   ├── development.py  # load depending on FLASK_ENV value
│   └── production.py
│
└── instance/           # directory for sensitive information
    └── config.py       # overrides default config
```
## Testing
To run the Flask API go to `pollex/pollex-flask/` and

```
$ flask run
```

Then (in another terminal) try it out. For example, to send a `POST` request with `cURL` to the `/polls/<poll_id>/vote`:
```
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"token":"123","option":"yes"}' \ # the json data
  http://localhost:5000/polls/123/vote # the endpoint
```
