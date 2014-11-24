## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

## Ridenfly API

Authorize: we don't need user so we can use client_id and client_secret from app as username and password

curl -X POST -i http://ridenfly.dev/oauth/token.json -d '{"grant_type":"password","username":"client_id","password":"client_secret"}' -H "Content-Type: application/json"


## Devise

===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================

## SimpleForm

===============================================================================

  Be sure to have a copy of the Bootstrap stylesheet available on your
  application, you can get it on http://twitter.github.com/bootstrap.

  Inside your views, use the 'simple_form_for' with one of the Bootstrap form
  classes, '.form-horizontal', '.form-inline', '.form-search' or
  '.form-vertical', as the following:

    = simple_form_for(@user, html: {class: 'form-horizontal' }) do |form|

===============================================================================

## Old system account types

    class Admin < User
    class Affiliate < User
    class Company < User
    class Csr < User
    class Customer < User
    class Seo < User

## Export yaml from old system

  Active companies

    File.open('companies.yaml', 'w'){|f| f.write Company.all(:conditions => [ "id in (?)",  Rate.all(:select  => 'distinct(company_id)').map(&:company_id)]).to_yaml }

  All airports

    File.open('airports.yml', 'w')  {|f| f.write Airport.all.to_yaml }
