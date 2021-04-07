## Dockerfile
```
FROM python:3.8-alpine
EXPOSE 8000
WORKDIR /code
COPY requirements.txt /code
RUN pip3 install -r requirements.txt
COPY . /code
CMD python manage.py runserver 0.0.0.0:8000
```

Create image from Dockerfile
```
docker build -t django-app .
```

List images
```
docker images
```

Create container from image
```
docker run -d -p 8000:8000 --name django-app django-app
```

List containers
```
docker ps
```

Stop container
```
docker stop <id>
```

## Docker Compose
docker-compose.yml
```
version: '3'
services:
  db:
    image: postgres:13-alpine
    environment:
      - POSTGRES_DB=pgdb
      - POSTGRES_USER=pguser
      - POSTGRES_PASSWORD=pgpassword
    ports:
      - "5432:5432"

  app:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - DB_HOST=db
      - DB_NAME=pgdb
      - DB_USER=pguser
      - DB_PASS=pgpassword
    depends_on:
      - db
    ports:
      - '8000:8000'
```
settings.py
```
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'HOST': os.environ.get('DB_HOST'),
        'NAME': os.environ.get('DB_NAME'),
        'USER': os.environ.get('DB_USER'),
        'PASSWORD': os.environ.get('DB_PASS'),
    }
```
Dockerfile
```
FROM python:3.8-alpine
EXPOSE 8000
WORKDIR /code
COPY requirements.txt /code
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
RUN pip3 install -r requirements.txt
COPY . /code
CMD python manage.py runserver 0.0.0.0:8000
```

Build image(s) in docker-compose.yml
```
docker-compose build
```

Start container(s)
```
docker-compose up -d
```

Migrate app
```
docker exec -it <container_id> python manage.py migrate
or
docker-compose run --rm app python manage.py migrate
```

Create superuser
```
docker exec -it <container_id> python manage.py createsuperuser
or
docker-compose run --rm app python manage.py createsuperuser
```

Stop container(s)
```
docker-compose down
```

## Make data persistent
docker-compose.yml
```
version: '3'
services:
  db:
    image: postgres:13-alpine
    environment:
      - POSTGRES_DB=pgdb
      - POSTGRES_USER=pguser
      - POSTGRES_PASSWORD=pgpassword
    ports:
      - "5432:5432"
    volumes:
      - db-data:/var/lib/postgresql/data

  app:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - DB_HOST=db
      - DB_NAME=pgdb
      - DB_USER=pguser
      - DB_PASS=pgpassword
    depends_on:
      - db
    ports:
      - '8000:8000'

volumes:
  db-data:
```
