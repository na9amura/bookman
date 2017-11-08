FROM ruby:2.4.2-alpine3.6

ENV APP_ROOT /usr/src/bookman

WORKDIR $APP_ROOT

RUN apk update \
  && apk upgrade \
  && apk add --update \
    build-base \
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
    curl \
  && rm -rf /var/cache/apk/* \
  && touch ~/.bashrc \
  && curl -o- -L https://yarnpkg.com/install.sh | sh \
  && apk del curl

ENV PATH /root/.yarn/bin:$PATH

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN echo 'gem: --no-document' >> ~/.gemrc \
  && cp ~/.gemrc /etc/gemrc \
  && chmod uog+r /etc/gemrc \
  && bundle config --global build.nokogiri --use-system-libraries jobs 4 \
  && rm -rf ~/.gem

COPY . $APP_ROOT

## compile webpack (for development)
#RUN \
#  bin/webpack

EXPOSE 9292 8080
CMD foreman start
