ARG RUBY_VERSION=3.4.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs sqlite3

COPY . .

RUN bundle install && npm install

RUN mkdir -p storage
COPY ./storage/development.sqlite3 ./storage/development.sqlite3

EXPOSE 3000