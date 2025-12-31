# Use official PostgreSQL Alpine image for smaller size
FROM postgres:16-alpine

# Set metadata labels
LABEL maintainer="tino@euangelionsoftware.com"
LABEL description="PostgreSQL Database Server with persistent storage"

# Install additional tools (optional - uncomment if needed)
# RUN apk add --no-cache bash curl vim

# Default environment variables (these will be overridden by docker-compose.yml)
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=mydb
ENV PGDATA=/var/lib/postgresql/data/pgdata

# Copy initialization SQL scripts to run on first startup
# Scripts in this directory are executed in alphabetical order
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Expose PostgreSQL default port
EXPOSE 5432

# Health check to ensure PostgreSQL is ready to accept connections
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
  CMD pg_isready -U ${POSTGRES_USER} || exit 1

# Note: ENTRYPOINT and CMD are inherited from the base postgres image
# They are configured to run the PostgreSQL server automatically

