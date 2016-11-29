# README

* Ruby version - 2.3.0p0
* Rails version - 5.0.0.1
* Database - postgresql
* Add database username and password to the secrets.yml file. Also, specify an 256 bit encryption key.
  For development/testing, can copy and use the secret_key_base.
* To run app, create and seed the database using `bundle exec rails db:drop db:create db:migrate db:seed tmp:clear log:clear --trace`
* Run `rails s` to start the server
* Run `bundle exec rspec spec` to run the test suite.
