ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  def clear_reports
    Report.all.each { |r| r.remove }
  end
  
  def clear_tags
    Tag.all.each { |t| t.remove }
  end
  
  
end


class ActionController::TestCase
  
  include Devise::TestHelpers
  
  
end


def puts! args
  
  puts '+++ +++'
  begin
    args.each do |a|
      puts a.inspect
    end
  rescue
    args.inspect
  end
  
end