FROM python:3.7-alpine3.7

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code

ADD requirements.txt /code/

# Update the system
RUN apk update && apk upgrade

RUN apk add --no-cache tzdata
ENV TZ Europe/Kiev

RUN \
 apk add --no-cache postgresql-libs libxslt-dev && \
 apk add --no-cache --virtual .build-deps gcc git make musl-dev postgresql-dev libffi-dev libressl libressl-dev libxml2-dev && \
 pip install -r requirements.txt --no-cache-dir && \
 apk --purge del .build-deps

ADD ./code/ /code/