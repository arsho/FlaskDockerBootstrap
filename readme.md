## Develop Flask Application using Docker and Bootstrap Templates
### Prerequisite
`Docker Engine` should be installed in local machine.
Instructions on installing `Docker Engine` can be found in the previous blog post: [Install Docker on Ubuntu 18.04](https://arshovon.com/blog/install-docker-on-ubuntu-18-04/)


### Environment

* <b> Operating System</b> : Ubuntu 18.04 LTS (64-bit)
* <b> Processor</b> : Intel® Core™ i7-8750H CPU @ 2.20GHz × 12
* <b> Memory</b> : 15.3 GiB

### Code Repository and Tutorial URL

All codes used in this tutorial can be found in this Github repository here:
[https://github.com/arsho/FlaskDockerBootstrap](https://github.com/arsho/FlaskDockerBootstrap)

This tutorial was originally published here:
[https://arshovon.com/blog/develop-flask-app-using-docker-and-bootstrap/](https://arshovon.com/blog/develop-flask-app-using-docker-and-bootstrap/)


### Folder structure:
  ```
  .
  ├── app.py
  ├── Dockerfile
  ├── readme.md
  ├── requirements.txt
  ├── static
  │   ├── css
  │   │   ├── bootstrap.css
  │   │   ├── bootstrap.css.map
  │   │   ├── bootstrap-grid.css
  │   │   ├── bootstrap-grid.css.map
  │   │   ├── bootstrap-grid.min.css
  │   │   ├── bootstrap-grid.min.css.map
  │   │   ├── bootstrap.min.css
  │   │   ├── bootstrap.min.css.map
  │   │   ├── bootstrap-reboot.css
  │   │   ├── bootstrap-reboot.css.map
  │   │   ├── bootstrap-reboot.min.css
  │   │   └── bootstrap-reboot.min.css.map
  │   ├── images
  │   │   ├── bootstrap.png
  │   │   ├── docker.png
  │   │   └── flask.svg
  │   └── js
  │       ├── bootstrap.bundle.js
  │       ├── bootstrap.bundle.js.map
  │       ├── bootstrap.bundle.min.js
  │       ├── bootstrap.bundle.min.js.map
  │       ├── bootstrap.js
  │       ├── bootstrap.js.map
  │       ├── bootstrap.min.js
  │       └── bootstrap.min.js.map
  └── templates
      └── index.html
  ```

`requirements.txt`:
  ```
  click==7.1.1
  Flask==1.1.1
  itsdangerous==1.1.0
  Jinja2==2.11.1
  MarkupSafe==1.1.1
  Werkzeug==1.0.0
  ```

`app.py`:
```
from flask import Flask, render_template


app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    return render_template("index.html")
```
`templates\index.html`:
```
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Flask Application using Docker</title>
  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="{{ url_for('static', filename='css/bootstrap.min.css') }}">
</head>
<body>
...
...
...
<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src={{ url_for('static', filename='js/bootstrap.min.js') }}></script>
</body>
</html>
```

`Dockerfile`:
```
FROM python:3

LABEL Author="Ahmedur Rahman Shovon"
LABEL E-mail="shovon.sylhet@gmail.com"
LABEL version="0.0.1"

ENV PYTHONDONTWRITEBYTECODE 1
ENV FLASK_APP "app.py"
ENV FLASK_ENV "development"
ENV FLASK_DEBUG True

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
EXPOSE 5000

CMD flask run --host=0.0.0.0
```

The above `Dockerfile` consists of the following sequential steps to execute when Docker image will be created:

1. It pulls `python:3` image from DockerHub.
2. It sets the author and version information of the `Dockerfile`.
3. It sets the environment variables necessary to run Flask application.
4. It creates a directory called `code` in the container and changed the working directory to `code`.
5. It copies `requirements.txt` to `code` and install all the packages listed in `requirements.txt` recursively.
6. It copies all the files to `code` directory.
7. It exposes `5000` port.
8. It runs the `Flask` application by defining a host so that the application can be accessed from outside the container.

**Build Docker Image:**
  Create a Docker image with tag `flask_example` from current directory.
  ```
  docker build -t flask_example .
  ```  
**Run Docker as background service:**
  Run the `flask_example` image in a container called `flask_container` as background service.
  ```
  docker run -d --name flask_container -p 5000:5000 flask_example  
  ```  
**Check running docker containers:**
```
docker ps -a
```

![alt docker run](/screenshots/docker_flask_bootstrap_run.png?style=center)

**Stop running docker container:**
```
docker stop flask_container
```
**Delete running docker container:**
```
docker rm flask_container
```
**Check installed Python packages inside the Docker container:**
```
docker exec -it flask_container pip freeze
```

**Output:**

![alt flask app](/screenshots/FLASK_DOCKER_BOOTSTRAP.png?style=center)



## Reference
* [Dev.to tutorial on dockerizing Flask app](https://dev.to/riverfount/dockerize-a-flask-app-17ag)
* [Boostrap front-end component library.](https://getbootstrap.com/)
