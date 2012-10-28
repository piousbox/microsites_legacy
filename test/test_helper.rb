
ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test_extensions'

class ActiveSupport::TestCase
  
end


class ActionController::TestCase  
  include Devise::TestHelpers
  
  
end


def puts! args
  puts '+++ +++'
  puts args.inspect
end

def clear_reports
  Report.all.each { |r| r.remove }
end
  
def clear_tags
  Tag.all.each { |t| t.remove }
end

def setup_users
  User.all.each { |u| u.remove }
  UserProfile.all.each { |p| p.remove }
    
  @user = FactoryGirl.create :user
  @piousbox = FactoryGirl.create :piousbox
  @pi_pt = FactoryGirl.create :pi_pt
  @pi_en = FactoryGirl.create :pi_en
  @pi_ru = FactoryGirl.create :pi_ru
end