FROM ruby:2.3-slim
# Installs dependencies
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev
# Sets install path
ENV INSTALL_PATH /usr/src/app
# Creates our workdir
RUN mkdir -p $INSTALL_PATH
# Sets our workdir to install path variable
WORKDIR $INSTALL_PATH
# Copies our gemfile to the container
COPY Gemfile ./
# Installs all gems
RUN bundle install
# Copies our project to the container
COPY . .
# Runs our server
CMD puma -C config/puma.rb