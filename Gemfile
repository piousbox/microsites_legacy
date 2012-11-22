source 'https://rubygems.org'

gem 'rails', '~> 3.2.3'

gem 'mongoid'
gem 'kaminari'
gem 'activeadmin-mongoid', :git => 'https://github.com/piousbox/activeadmin-mongoid.git', :branch => 'fix_sidebar_disable'

# gem 'mysql2', '0.3.11'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'
gem 'haml'
gem 'tinymce-rails'
gem 'coffee-filter'
gem 'jquery-fileupload-rails'

gem 'devise'
gem 'cancan', '~> 1.5'

gem 'aws-sdk'
gem 'paperclip'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-s3",            :require => "aws/s3"

group :production do
  gem 'unicorn'
  # gem 'passenger'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest'
  gem 'mocha'
  gem 'rspec-rails-mocha', '~> 0.3.1', :require => false
end

group :development, :test do
  gem 'rspec-rails', '~> 2.4'
  gem "capybara"
  # gem 'webrat'
  # either webrat or capybara
  
end

