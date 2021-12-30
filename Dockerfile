FROM ruby:3.0.0-alpine3.13

RUN apk --no-cache add g++ make sqlite sqlite-dev mysql-dev
WORKDIR /app
COPY Gemfile /app
RUN bundle install

COPY . /home/app
WORKDIR /home/app
