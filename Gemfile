#-*-ruby-*-
source :gemcutter
source "http://gems.github.com/"

gem 'rake', '0.8.7'
gem 'rails', '3.0.9'
gem 'curb'
gem 'json'
gem 'twitter'
gem 'flickr'
gem 'starling'
gem 'airbrake'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'annotate'
  gem 'heroku'
  gem 'mysql2', '< 0.3'
  gem 'rspec-rails'
  gem 'webrat'
  gem 'factory_girl_rails', '1.0'

  # http://ruby.railstutorial.org/chapters/static-pages#sec:testing_tools
  gem 'autotest'
  gem 'autotest-rails-pure'
end

group :mac_autotest do
  # http://ruby.railstutorial.org/chapters/static-pages#sec:testing_tools
  #gem 'autotest-fsevent' if RUBY_PLATFORM =~ /darwin/
  #gem 'autotest-growl'
end

group :unix_autotest do
  # http://www.ruby-forum.com/topic/764346
  gem 'term-ansicolor'
  gem 'turn'
end

