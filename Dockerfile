FROM python:3.8-alpine
EXPOSE 8000
WORKDIR /code
COPY requirements.txt /code
# RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip3 install -r requirements.txt
COPY . /code
CMD python manage.py runserver 0.0.0.0:8000