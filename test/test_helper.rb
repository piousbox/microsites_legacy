ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  def puts! arg
    puts '+++ +++'
    puts arg.inspect
  end
  
  def clear_reports
    Report.all.each { |r| r.remove }
  end
  
  def clear_tags
    Tag.all.each { |t| t.remove }
  end
  
  
  
end
