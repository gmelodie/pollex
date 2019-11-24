FROM ubuntu:19.10
FROM python:3.7

RUN mkdir /home/demo

WORKDIR /home/demo

RUN pip install flask

COPY ex-01.py .
COPY templates/* templates/
COPY static/* static/

ENV FLASK_APP=ex-01.py
ENV FLASK_ENV=development

EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["ex-01.py"]
