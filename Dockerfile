FROM elixir:1.6.5

# Install HTTPS support for apt-get and other necessary utilities not included in the slim slim base image:
# curl (for installing stuff), git (for mix deps.get), and make (for the Elixir OAuth package), inotify-tools (for live reloading in dev)
RUN apt-get update && apt-get install -y apt-transport-https curl git make inotify-tools gnupg g++

# Install the Javascript dependencies
# We have to explicitly set up the system to install Node 7; by default it's 0.10, oddly
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && curl -sL https://deb.nodesource.com/setup_8.x | bash \
      && apt-get install -y nodejs yarn

RUN yarn global add elm@0.18.0 && yarn global add elm-github-install
RUN yarn global add elchemy
RUN yarn global add fsmonitor

# Install Elixir Deps
RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix hex.info

ADD /app /app
WORKDIR /app
RUN yes | elchemy init