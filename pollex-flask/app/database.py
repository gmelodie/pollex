from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class BaseMixin(object):
    @classmethod
    def create(cls, **kwargs):
        r = cls(**kwargs)
        return r.save()

    def save(self, commit=True):
        db.session.add(self)
        if commit:
            db.session.commit()
        return self
