# AM Translations
An online tool for making books and articles translations collaboratively

## Technology

You may want to be familiar with these technologies if you want to start hacking some code:

* [Git](http://git-scm.org): The powerful revision control system.
* [Ruby](http://www.ruby-lang.org) 2.4.1
* [Rails](http://rubyonrails.org) 5.1.0
* [PostgreSQL](https://www.postgresql.org) 9.6
* [ReactJS](https://facebook.github.io/react/) 15.6

## Setup

Make sure you have these installed before proceeding to download.

### Ruby version
Usually its considered a good idea to have a ruby manager like **rvm** or **rbenv**.
This guide expects you to have at least ruby 2.3 installed

### Installation
To get rolling, start by copying the environment file.
From the application root run the following:

   . `cp .env.sample .env`

### Configuration

Since AM-Translations is a [Rails](http://rubyonrails.org) 5.1 application, you need to run the following after downloading the code:

  1. `$ cd am-translations`
  2. `$ yarn install`
  3. `$ bundle install`
  4. `$ bundle exec rake db:create db:migrate`

You may want to load sample data into database for filling languages etc:

`$ bundle exec rake db:seed`

#### Starting the server
Install foreman gem using the command: `gem install foreman`.

Start all development servers:

`$ foreman start`

Now, you may visit the following URLs:

* Application Server: http://localhost:3000/
