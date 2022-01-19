FROM ruby:2.7.5

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qqy && apt-get -qqyy install \
    nodejs \
    yarn

RUN apt-get install -y \ 
  build-essential \ 
  nodejs \
  zip \
  tzdata \
  curl \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
  
WORKDIR /app

COPY package.json ./

COPY .irbrc /root/.irbrc

RUN npm rebuild node-sass --force

ADD Gemfile* /app/
RUN gem install bundler --pre
RUN bundle install

ADD . /app
