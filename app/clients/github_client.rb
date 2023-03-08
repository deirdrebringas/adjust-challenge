# frozen_string_literal: true

class GithubClient
  attr_accessor :client

  def initialize
    @client = Octokit::Client.new
  end

  def search_repositories(query:, page:)
    # depending on the underlying implementation of the endpoint on GitHub's side,
    # it could be good to sanitise the query and make sure it's valid
    results = client.search_repositories(query, page:)

    return false unless client.last_response.status == 200

    page_items =
      results[:items].map do |item|
        {
          name: item[:full_name],
          description: item[:description],
          url: item[:html_url],
          forks: item[:forks],
          language: item[:language],
          stars: item[:stargazers_count]
        }
      end
    response_relations = client.last_response.rels

    {
      page_num: page.to_i,
      page_items:,
      first: response_relations[:first].present? ? 1 : nil,
      prev: response_relations[:prev].present? ? page.to_i - 1 : nil,
      next: response_relations[:next].present? ? page.to_i + 1 : nil,
      last: response_relations[:last].present? ? find_last_page(response_relations[:last].href) : nil
    }
  end

  private

  def find_last_page(url)
    # the page number is always the last number of the URL
    url.scan(/\d+/).last
  end
end
