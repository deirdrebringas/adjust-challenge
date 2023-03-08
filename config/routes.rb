# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :github do
    get 'repositories', to: 'repositories#index'
  end
end
