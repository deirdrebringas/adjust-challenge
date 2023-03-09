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

Note: This will temporarily open a browser


## Structure

This project follows the standard Rails structure, however I will mention the more important files to the project

* `config`:
    * `initializers/octokit`: initialises the Octokit gem, a toolkit for interacting with the GutHub API
* `app`:
    * `assets/stylesheets/application.css`: css classes used for the views. For larger applications, I would use more scoped css files, having individual ones for each view or components.
    * `controllers/github/repositories_controller.rb`: the controller used for the github repositories that calls upon the `GithubClient`in order to process the query based on the query params: `query`, `page`. This returns a `200`response regardless of the response from GitHub, however should there be an error, this is handled via an error state on the page.
    * `clients/github_client.rb`: a wrapper for the Octokit library used to communicate with GitHub. 
    * `views/github/repositores/index.html.erb`: the view for the page with and without search results.
    * `views/github/repositores/_repositories_.html.erb`: the partial for the search results depending on the response from GitHub.
* `spec`:
    * `clients/github_client_spec.rb`: test file for the `GithubClient` containing unit tests using RSpec
    * `integration/github/repositories_spec.rb`: test file for the search feature using the Capybara library
