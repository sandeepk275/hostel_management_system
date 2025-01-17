FROM ruby:3.0.1

# Install system dependencies for Nokogiri and PostgreSQL
RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  build-essential \
  libpq-dev \
  libxml2-dev \
  libxslt-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ /tmp/ /var/tmp/*

# Create a non-root user
RUN groupadd -r -g 1000 docker && \
    useradd -r --create-home -u 1000 -g docker docker

WORKDIR /backend-api

# Copy Gemfile and Gemfile.lock
COPY Gemfile /backend-api/Gemfile
COPY Gemfile.lock /backend-api/Gemfile.lock

# Install gems
RUN bundle install --jobs 4 --retry 3

# Set permissions for files and directories
RUN chown -R docker:docker /backend-api && \
    chmod g+w /backend-api/Gemfile.lock

# Copy the entrypoint script and set permissions
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Switch to non-root user
USER docker

# Copy the application code
COPY . /backend-api

ENTRYPOINT ["entrypoint.sh"]