#
# docker build -t my-python-app .
# docker run -it --rm --name my-running-app -v "$(PWD)":/code my-python-app
#

FROM python:2
MAINTAINER Portia Dean

RUN apt-get update && apt-get install -y \
	sqlite3 \
	libsqlite3-dev

COPY . /code
WORKDIR /code

CMD [ "python", "./gcdEclid.py" ]
