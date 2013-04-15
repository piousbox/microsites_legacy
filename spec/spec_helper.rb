# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'capybara/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  
  config.include Devise::TestHelpers, :type => :controller
  # config.include Devise::TestHelpers
  # include Devise::TestHelpers

end

Paperclip.options[:log] = false
Mocha::Deprecation.mode = :disabled
  
def puts! args
  puts '+++ +++'
  puts args.inspect
end

class ActionController::TestCase
  include Devise::TestHelpers
  Paperclip.options[:log] = false
  Mocha::Deprecation.mode = :disabled
end

def setup_users
  User.all.each { |c| c.remove }
  @user = FactoryGirl.create :user
  @anon = FactoryGirl.create :anon
  @simple = FactoryGirl.create :simple
  @user_2 = FactoryGirl.create :user_2
  @manager = FactoryGirl.create :manager
  @piousbox = FactoryGirl.create :piousbox
end

def setup_sites
  Site.all.each { |s| s.remove }
  FactoryGirl.create :test_site
  FactoryGirl.create :site_piousbox
  FactoryGirl.create :site_piousbox_ru
  FactoryGirl.create :site_piousbox_pt

end

def set_user_agent_iphone
  request.stub!(:user_agent).and_return('Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16')
end
