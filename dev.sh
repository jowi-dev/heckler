#!/bin/bash

# Start the PostgreSQL container
echo "Starting PostgreSQL container..."
docker-compose up -d

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
sleep 5

# Set up the development environment
echo "Setting up development environment..."
mix heckler.dev.setup

echo "Development environment is ready!"
echo "You can now run tests with: mix test"
echo "Or send a test SMS with: mix run textme.exs \"+15023206035\" \"Hello world\""
echo "Or schedule a test SMS with: mix run \"dev/schedule_sms.exs\" \"+15023206035\" \"Scheduled test\" 5"