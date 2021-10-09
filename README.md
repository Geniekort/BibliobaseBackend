# Bibliobase Backend

Welcome to the backend of Bibliobase, created as part a masters thesis at the Eindhoven University of Technology (TU/e). The source code of the frontend (Vue) application is in [a different repository](https://github.com/Geniekort/Bibliobase). The frontend connect to this backend using the GraphQL API of this app.


## Intial setup:

### Build Rails application

    $ docker-compose build 

### Initialize and seed database with simple example project

    $ docker-compose run bibliobase_app bundle exec rails db:create db:schema:load db:seed

### Create a (new) user
First start Rails Console

    $ docker-compose run bibliobase_app bundle exec rails c

Then create a new user:

    $ u = User.create(email: “user@email.com”, name: “Username”, password: “testpassword”)

Then confirm the user (which would normally go through an email):

    $ u.confirm


## Running application
To start developing this application simply run: 

    $ docker-compose up --build

Now, the (GraphQL) API is running on localhost:3000


## Test

To run the tests, execute the following command:

    $ docker-compose run bibliobase_app bundle exec rpsec ./spec
