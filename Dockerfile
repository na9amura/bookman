# FROM ruby:2.4.1-alpine
FROM artwishlist/alpine-3.6-ruby-2.4.1

ENV APP_ROOT /usr/src/bookman

WORKDIR $APP_ROOT

RUN \
  apk update && \
  apk upgrade && \
  apk add --update \
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    mysql-client \
    postgresql-client \
    sqlite-dev \
    tzdata \
    git\
    yarn\
    openssl\
    && \
  rm -rf /var/cache/apk/*

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

COPY . $APP_ROOT

# compile webpack (for development)
RUN \
  bin/webpack

EXPOSE  9292
CMD ["rails", "server", "-b", "0.0.0.0", "-p","9292"]
