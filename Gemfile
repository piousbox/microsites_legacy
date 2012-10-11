source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'mongoid'
gem 'kaminari'
gem 'activeadmin-mongoid', :git => 'https://github.com/piousbox/activeadmin-mongoid.git', :branch => 'fix_sidebar_disable'

gem 'mysql2', '0.3.11'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'
gem 'tinymce-rails'

gem 'devise'
gem 'cancan'

gem 'aws-sdk'
# gem "paperclip", :git => "http://github.com/thoughtbot/paperclip.git", :branch => 'v3.2'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-s3",            :require => "aws/s3"

group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl_rails'
end