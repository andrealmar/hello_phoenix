# base image elixir
FROM elixir:1.6-slim

# skip post-install steps
ENV DEBIAN_FRONTEND=noninteractive

# install Hex package manager
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# install the latest version of Phoenix Framework
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# Install NodeJS 6.x and the NPM
RUN apt-get update; apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs

# create app folder
WORKDIR /app
ADD . /app

# install dependencies
RUN mix deps.get

# run phoenix in *dev* mode on port 4000
# CMD mix phoenix.server