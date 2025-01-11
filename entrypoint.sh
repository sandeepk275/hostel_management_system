#!/bin/bash
set -e

# Remove any pre-existing server.pid to avoid conflicts on startup
rm -f tmp/pids/server.pid

# Run database creation and migrations (ensure DB exists and is up to date)
bundle exec rake db:create
bundle exec rake db:migrate

# Now run the main command (Rails server)
exec "$@"
