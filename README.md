# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

For token authentication with JWT and gem knock.

view the following resources https://github.com/nsarno/knock, https://dev.to/amckean12/user-authentication-for-a-rails-api-and-a-react-client-part-1-server-side-3fej, 
fix error https://gorails.com/forum/1-how-to-build-apis-with-rails-api-authentication-with-json-web-tokens-jwt-and-knock  , https://gorails.com/users/6841

1- Put in the Gemfile the following gems and run bundle install command:

gem 'knock' # Authentication Solution
gem 'bcrypt', '~> 3.1.7' # To hash our passwords
gem 'active_model_serializers' #Used to serialize our data (Note: As of this writing AMS is undergoing large development changes, if looking for another solution I'd recommend fast_jsonapi)
gem 'jwt' #Ruby implementation of RFC 7519 OAuth JWT standard
gem 'rack-cors' #this is a necessary for communication with our client

2- run: rails generate knock:install

3- run: rails generate knock:token_controller user

4- include in the app/controllers/user_token_controller.rb inside the class
    # in rails 5.2
    skip_before_action :verify_authenticity_token

5-  include in the model user:
    has_secure_password

6- include in the file config/application.rb
    change from config.load_defaults 6.0 to :
    # solve problem  uninitialized constant Knock::Authenticable
    config.load_defaults 6.0 and config.autoloader = :classic
7- include in the app/controllers/application_controller.rb inside the class
    include Knock::Authenticable




* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
