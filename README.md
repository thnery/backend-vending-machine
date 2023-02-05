# README - Backend Vending Machine

Running application can be found at: https://radiant-stream-56900.herokuapp.com/api-docs/index.html
The application uses JWT for Authentication. The Postman colletion can be found at the root of the project.

## Requirements

* Ruby 3.1.2
* Rails 7+
* Postgres 14

## Running Locally

Run `bundle exec rails server -p 3000`

In case you need to up the database, run `docker compose up -d`

## Running Tests

Run `bundle exec rspec`

Specs were writen for the endpoints bellow:

* `/deposit`
* `/buy`
* CRUD of Products
