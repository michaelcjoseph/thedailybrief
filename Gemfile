source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use Rails API
gem 'rails-api'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Responders modules for Rails
gem 'responders'
# Handle JSON objects
gem 'json'
# Read and parse RSS & Atom Feeds
gem 'simple-rss'
# Manage the REST client
gem 'rest-client'
# Read and parse HTML docs
gem 'nokogiri'
# Web server to replace default Webrick
gem 'puma'
# Patches OpenURI to allow for http -> https redirections and vice versa
gem 'open_uri_redirections'

# Gems for authentication
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'devise_token_auth'

# Gem for mailer using Sparkpost
gem 'simple_spark'

# Gem for error notifications
gem 'exception_notification-rake', '~> 0.3.0'

# Gem for CORS (necessary for dev environment)
gem 'rack-cors', :require => 'rack/cors'

# Gem for Naive Bayesian Algorithm
gem 'nbayes'

# Gem to stem words for Bayesian Algorithm
gem 'stemmify'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
	gem 'rails_12factor'

  # GZip files for heroku
  gem 'heroku-deflater'
end