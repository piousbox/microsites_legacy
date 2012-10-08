source 'https://rubygems.org'

gem 'rails', '3.2.3'

gem 'mongoid' # , '2.0.2'


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'haml'

gem 'activeadmin-mongoid',
  :git => 'https://github.com/piousbox/activeadmin-mongoid.git',
  :branch => 'fix_sidebar_disable'


gem 'devise'
gem 'cancan'
gem 'kaminari'
gem 'bson_ext'

group :production do
  gem 'unicorn'
end

group :test do
  gem 'factory_girl_rails'
end