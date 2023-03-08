# frozen_string_literal: true

module Github
  class RepositoriesController < ApplicationController
    def index
      return unless search_query[:query].present?

      github_client = GithubClient.new
      page = search_query[:page] || 1
      @response = github_client.search_repositories(query: search_query[:query], page:)

      # We can also return specific statuses based on the specific response from GitHub
      # e.g. if the query failed validation on GitHub's end
      unless @response
        render status: :service_unavailable
      end
    end

    private

    def search_query
      params.permit(:query, :page)
    end
  end
end
