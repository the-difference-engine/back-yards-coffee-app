FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
ENV PATH=/usr/src/app/bin:$PATH RAILS_ENV=development
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app