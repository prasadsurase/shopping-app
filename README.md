# README

* Ruby version - 2.3.0p0
* Rails version - 5.0.0.1
* Database - postgresql
* Add database username and password to the secrets.yml file. Also, specify an 256 bit encryption key.
  For development/testing, can copy and use the secret_key_base.
* To run app, create and seed the database using `bundle exec rails db:drop db:create db:migrate db:seed tmp:clear log:clear --trace`
* Run `rails s` to start the server
* Run `bundle exec rspec spec` to run the test suite.

# Assumptions

* Items and Promotion Codes are already present in the system and we have a admin panel from where the data can be added/updated/deleted.
* Customer email is unique and credit cards numbers are unique.
* A Customer can have multiple credit cards and they are reused if the same number is provided during billing.
* A Customer is identified by the email
* A Customer can have only one basket at any give time until the order has been placed.
* £ is the currency.


# Approach

* No data should be persisted unless atleast one item is added to the basket.
* Since we dont have user related session, we save the current basket reference(id) in the session. That data exists until then basket is emptied
  or order has been placed.
* We allow the user to select the items and add them to the basket. Later on, the basket contents can be updated/removed.
* If an existing email is provided during billing, the order is assigned to the same Customer.
* An new entry for credit card is created for the related customer if the number has changed.
* If the promotion code offers discount greater than or equal to the total price before discount, then the order is free. ie. final amount is 0.
* We list the Promotion Codes so that user can apply each one and check the available discount.
* Once the payment is confirmed, we empty the basket and list the confirmed order in the 'Orders Placed' page.
* Orders once placed/confirmed, cant be updated or deleted.
