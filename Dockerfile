FROM ruby:3.4.2-alpine

RUN apk add --no-cache build-base git vips libpq-dev postgresql-client tzdata less yaml-dev

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/
RUN bundle install -j4

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]