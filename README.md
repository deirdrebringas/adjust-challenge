# README

This is a full-stack implementation of a GitHub Repository search as a part of the Adjust Coding Challenge.

## Requirements

This project requires the following versions:

* Ruby 3.2.1
* Rails 7

## Setup & Usage

After cloning the repository and navgating to the folder, run the setup script in order to install the application's gems

```ruby
bin/setup
```

The server can now be started on port 3000 (or another free one of your choosing)

```ruby
bin/rails s -p 3000
```

Once the server has been started, the application is available through [http://localhost:3000/github/repositories](http://localhost:3000/github/repositories).

Type in a search term, press enter, and enjoy!


## Tests

Test files are located within the `spec` folder and can be run with the following command:

```ruby
bundle exec rspec
```
