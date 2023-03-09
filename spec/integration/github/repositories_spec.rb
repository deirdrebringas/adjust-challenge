require 'rails_helper'

RSpec.describe 'Repository search', type: :feature do
  scenario 'initial page without search query' do
    visit github_repositories_path

    expect(page.status_code).to be(200)
    expect(page).to have_content('Adjust Challenge: GitHub Repository Search')
    expect(page).to have_field('query', placeholder: 'Enter repository name')
    # the list of repositories hass the css class "list"
    expect(page).not_to have_css('ul.list')
  end

  scenario 'page with search results', js: true do
    mock_response = {
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

    allow_any_instance_of(GithubClient).to receive(:search_repositories)
      .and_return(mock_response)

    visit github_repositories_path

    expect(page).to have_content('Adjust Challenge: GitHub Repository Search')
    expect(page).to have_field('query', placeholder: 'Enter repository name')

    fill_in 'query', with: 'this is a query'
    find('div.form form input#query').native.send_keys(:return)

    expect(page).to have_css('ul.list')
    # one list-item is the result & the other is the list actions (first, prev, next, last)
    expect(page).to have_css('li.list-item', count: 2)
    expect(page).to have_content('dtrupenn/Tetris')
    # the four navigation buttons are disabled due to the nil values
    expect(page).to have_css('a.disabled', count: 4)
  end

  scenario 'page with a non 200 response from GitHub', js: true do
    allow_any_instance_of(Octokit::Client).to receive_message_chain(:last_response, :status).and_return(422)

    visit github_repositories_path

    expect(page).to have_content('Adjust Challenge: GitHub Repository Search')
    expect(page).to have_field('query', placeholder: 'Enter repository name')

    fill_in 'query', with: 'this is a query'
    find('div.form form input#query').native.send_keys(:return)

    # the list of repositories hass the css class "list"
    expect(page).not_to have_css('ul.list')
    expect(page).to have_css('div.error')
    expect(page).to have_content('Oh no! Something\'s not quite right...')
  end
end
