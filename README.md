# TuTutor README
TuTutor backend application.

## Ruby version
The project ruby version is 2.7.1, using Rails gem in its 6.0.2.2 version.

## Set Up
Firstly you must create an `.env` file starting from the `.env.sample` already in the project, otherwise your set up won't work.
```bash
# Clone repository
git clone https://github.com/Fralez/tututor-backend.git && cd tututor-backend/
# Install gems
bundle install
# Set up DB
rails db:setup
# Run migrations
rails db:migrate
# Run seeds (if any)
rails db:seed
# Run server
rails server
```

Useful commands:
```bash
# Eliminate completely database
rails db:drop
# Access to rails server console
rails console
```