FROM tensorflow/tensorflow:latest-py3

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /usr/src/app && apt-get update && apt-get --install-suggests --yes dist-upgrade && apt-cache pkgnames python3 | egrep -i "^python3-(numpy|pyfftw|soundfile|theano|keras|youtube.dl|matplotlib)$" | xargs apt-get --yes install \
    libfftw3-dev \
    liblapack-dev \
    youtube-dl

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip3 install --compile --process-dependency-links -r requirements.txt --upgrade

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD COPY . /usr/src/app

ONBUILD RUN CFLAGS="-march=native" pip3 install --force-reinstall --compile --process-dependency-links -r requirements.txt --upgrade
