source 'https://rubygems.org'

gem 'rails', '~> 3.2.3'

gem 'mongoid'
gem 'kaminari'

# gem 'activeadmin-mongoid', :git => 'https://github.com/piousbox/activeadmin-mongoid.git', :branch => 'fix_sidebar_disable'
# gem 'mysql2', '0.3.11'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'haml'
gem 'tinymce-rails'
gem 'coffee-filter'
gem 'jquery-fileupload-rails'
gem 'jquery-rails'
gem 'execjs'
# gem 'libv8', '~> 3.11.8'
gem 'therubyracer'# , :require => 'libv8'

gem 'nokogiri', '~> 1.5.9'

gem 'devise'
gem 'cancan', '~> 1.5'
gem "bcrypt-ruby", :require => "bcrypt"

gem 'aws-sdk'
gem 'paperclip'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-s3",            :require => "aws/s3"
gem "recaptcha",         :require => "recaptcha/rails"

gem 'mobile-fu'

group :production do
  gem 'unicorn'
  # gem 'passenger'
end

group :test do
  gem 'factory_girl_rails'
  gem 'minitest'
  gem 'mocha', :require => false
  gem 'rspec-rails-mocha', '~> 0.3.1', :require => false
  gem 'shoulda'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'ruby-prof'
end

group :development, :test do
  gem 'net-ssh', '2.4.0'
  gem "capybara"
  # gem 'thin'
end
