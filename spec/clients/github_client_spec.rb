require 'rails_helper'

RSpec.describe GithubClient do
  let(:service) { GithubClient.new }

  describe '#search_repositories' do
    context 'when the query is valid' do
      it 'returns a results object with the items and page references' do
        mock_page_infos = { first: nil, next: nil, prev: nil, last: nil }
        file_content = file_fixture('github/repositories.json').read
        repositories = JSON.parse(file_content, symbolize_names: true)
        allow_any_instance_of(Octokit::Client)
            .to receive_message_chain(:last_response, :rels).and_return(mock_page_infos)
        allow_any_instance_of(Octokit::Client).to receive_message_chain(:last_response, :status).and_return(200)
        allow_any_instance_of(Octokit::Client).to receive(:search_repositories).and_return(repositories)

        expected_response = {
          page_num: 1,
          page_items: [{
            name: 'dtrupenn/Tetris',
            description: 'A C implementation of Tetris using Pennsim through LC4',
            url: 'https://github.com/dtrupenn/Tetris',
            forks: 1,
            language: 'Assembly',
            stars: 1
          }],
          first: nil,
          prev: nil,
          next: nil,
          last: nil
        }

        response = service.search_repositories(query: 'some query', page: 1)

        expect(response).to eq(expected_response)
      end
    end

    context 'when the response from github is not 200' do
      it 'returns false' do
        allow_any_instance_of(Octokit::Client).to receive_message_chain(:last_response, :status).and_return(422)
        response = service.search_repositories(query: 'some query', page: 2)

        expect(response).to be false
      end
    end
  end
end
