FROM elixir:1.15-alpine

# Install build essentials and development tools
RUN apk add --no-cache build-base npm git inotify-tools bash postgresql-client

# Install Phoenix
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

WORKDIR /app

# Set development environment
ENV MIX_ENV=dev

# Command to start Phoenix server in development mode
CMD ["mix", "phx.server"]
