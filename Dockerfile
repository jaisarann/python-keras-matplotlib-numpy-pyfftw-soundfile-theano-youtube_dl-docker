FROM python:3

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /usr/src/app && apt-get update && apt-get --yes --install-suggests dist-upgrade && apt-cache pkgnames python | egrep -i "^python[0-9]*-(numpy|pyfftw|soundfile|theano|keras|youtube.+dl|matplotlib)$" | xargs apt-get --yes --install-suggests install youtube-dl

WORKDIR /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD COPY . /usr/src/app

ONBUILD RUN pip install --no-cache-dir -r requirements.txt
