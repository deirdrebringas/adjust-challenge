module Github
  class RepositoriesController < ApplicationController
    def index
      return unless search_query[:query].present?

      github_client = GithubClient.new
      page = search_query[:page] || 1
      @response = github_client.search_repositories(query: search_query[:query], page:)

      render :index, status: :ok
    end

    private

    def search_query
      params.permit(:query, :page)
    end
  end
end
