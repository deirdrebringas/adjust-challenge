# frozen_string_literal: true

Octokit.configure do |c|
  c.access_token = Rails.application.credentials[:github_access_token]
end
