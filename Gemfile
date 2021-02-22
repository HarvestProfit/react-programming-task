source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1'

gem 'active_model_serializers'
gem 'acts_as_list'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'jwt'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem 'codecov', require: false
  gem 'factory_bot_rails'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'aws-sdk-s3', require: false
end
