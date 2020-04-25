FROM python:3

LABEL Author="Ahmedur Rahman Shovon"
LABEL E-mail="shovon.sylhet@gmail.com"
LABEL version="0.0.1"

ENV PYTHONDONTWRITEBYTECODE 1
ENV FLASK_APP "app.py"
ENV FLASK_ENV "development"
ENV FLASK_DEBUG True
ENV FLASK_RUN_PORT 5000

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
EXPOSE 5000

CMD flask run --host=0.0.0.0
