source 'https://rubygems.org'

gem 'rails', '~> 3.2.3'
gem 'mongoid'
gem 'kaminari'
gem 'formtastic'
gem 'haml'
gem 'tinymce-rails'
gem 'formtastic'
gem 'newrelic_rpm'
gem 'coffee-filter'
gem 'jquery-rails'
gem 'jbuilder'
gem 'libv8', '~> 3.11.8'
gem 'therubyracer', :require => 'libv8'
gem 'nokogiri', '~> 1.5.9'
gem 'devise'
gem 'cancan', '~> 1.5'
gem "bcrypt-ruby", :require => "bcrypt"
gem 'aws-sdk'
gem 'paperclip'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-s3",            :require => "aws/s3"
gem "recaptcha",         :require => "recaptcha/rails"
gem 'jquery-fileupload-rails'

# gem 'activeadmin-mongoid', :git => 'https://github.com/piousbox/activeadmin-mongoid.git', :branch => 'fix_sidebar_disable'
# gem 'mysql2', '0.3.11
# gem 'execjs'

group :production do
  gem 'unicorn'
  # gem 'passenger'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest'
  gem 'mocha'
  gem 'rspec-rails-mocha', '~> 0.3.1'
  gem 'shoulda'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'ruby-prof'
  gem 'simplecov', :require => false
end

group :development, :test do
  gem 'net-ssh', '2.4.0'
  gem 'capybara'
  gem 'capistrano'
  gem 'quiet_assets'
  gem 'thin'
  gem 'delayed_job_mongoid'
  gem 'hpricot'
end

group :test, :development, :util do
  gem 'simple-rss', :git => "git://github.com/piousbox/simple-rss.git"
  gem 'htmlentities' # need with simple-rss
  gem 'resque'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'handlebars_assets'
  gem 'bootstrap-sass'
end
