# railsbridge-testfest

The skeleton app.

## Setup

* Clone the app from from Github.
* Run `bundle install`
* Change to the `config` folder (`cd config`) and run:

  ```
  cp secrets.yml.sample secrets.yml
  ```
* Create the database and run migrations: `rake db:migrate`
* Start the server with `rails server`
* Run tests with `rake spec` (Note: some tests will fail, you are now ready to fix them!)
