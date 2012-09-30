ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  
  
  def puts! arg
    puts '+++ +++'
    puts arg.inspect
  end
  
  def setup_host
    clear_tags
    @request.host = 'test.local'
    @main_tag = Tag.new :domain => 'test.local', :name => 'tag1'
    @main_tag.save
  end
  
  def clear_reports
    Report.all.each { |r| r.remove }
  end
  
  def clear_tags
    Tag.all.each { |t| t.remove }
  end
  
  
  
end
