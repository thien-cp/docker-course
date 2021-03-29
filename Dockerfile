FROM python:alpine
COPY . /code
WORKDIR /code
RUN pip3 install -r requirements.txt
EXPOSE 5000
CMD python app.py

