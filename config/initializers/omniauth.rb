Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, 
              ENV['GITHUB_KEY'],
              ENV['GITHUB_SECRET'],
              provider_ignores_state: true
    end
  OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'