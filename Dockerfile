FROM ruby:2.4.1

ENV APP_ROOT /usr/src/bookman

WORKDIR $APP_ROOT

# for yarn
RUN apt-get update
RUN apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# for node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN \
  apt-get update && \
  apt-get install -y \
    nodejs \
    mysql-client \
    postgresql-client \
    sqlite3 \
    yarn \
    --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

RUN gem install foreman

COPY . $APP_ROOT

EXPOSE 9292 8080
#CMD ["rails", "server", "-b", "0.0.0.0", "-p","9292"]
CMD foreman start
