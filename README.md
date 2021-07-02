# Bibliobase Backend

Welcome to the backend of Bibliobase, created as part a masters thesis at the Eindhoven University of Technology (TU/e). The source code of the frontend (Vue) application is in [a different repository](https://github.com/Geniekort/Bibliobase). The frontend connect to this backend using the GraphQL API of this app.

To start developing this application simply run: 

    $ docker-compose up --build


## Test

To run the tests, execute the following command:

    $ docker-compose run bibliobase_app bundle exec rpsec ./spec
