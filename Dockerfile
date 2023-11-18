FROM ruby:3.2.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec rake db:migrate
RUN bundle exec rake markdown:render_statement

CMD ["ruby", "./app.rb"]

EXPOSE 8080