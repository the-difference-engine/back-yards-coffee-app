FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /b
WORKDIR /boty-app
COPY Gemfile /boty-app/Gemfile
COPY Gemfile.lock /boty-app/Gemfile.lock
RUN bundle install
COPY . /boty-app