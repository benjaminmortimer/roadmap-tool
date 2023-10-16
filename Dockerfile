FROM ruby:3.2.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN bundle exec rake db:migrate

COPY . .

CMD ["ruby", "./app.rb"]

EXPOSE 8080