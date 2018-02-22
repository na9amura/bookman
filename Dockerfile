FROM ruby:2.4.2-alpine3.6

ENV APP_ROOT /usr/src/bookman

WORKDIR $APP_ROOT

RUN apk update \
  && apk upgrade --no-cache \
  && apk add --update --no-cache --virtual build-dependencies \
    curl \
    build-base \
  && apk add --update --no-cache \
    libc6-compat \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    mysql-client \
    postgresql-client \
    sqlite-dev \
    tzdata \
    git \
    openssl \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | sh

ENV PATH /root/.yarn/bin:$PATH

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN echo 'gem: --no-document' >> ~/.gemrc \
  && cp ~/.gemrc /etc/gemrc \
  && chmod uog+r /etc/gemrc \
  && bundle config --global build.nokogiri \
    -- --use-system-libraries \
    --with-xml2-config=/usr/bin/xml2-config \
    --with-xslt-config=/usr/bin/xslt-config \
  && bundle install --jobs 4 \
  && rm -rf ~/.gem \
  && apk del build-dependencies

COPY . $APP_ROOT

## compile webpack (for development)
#RUN \
#  bin/webpack

EXPOSE 9292 8080
CMD bundle exec foreman start
