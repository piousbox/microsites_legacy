
ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test_extensions'
require "mocha/setup"
require "open-uri"

class ActiveSupport::TestCase
  ;
end

class C # TestConfig
  def self.n_photos
    4
  end
end

class ActionController::TestCase  
  include Devise::TestHelpers
  Paperclip.options[:log] = false
  Mocha::Deprecation.mode = :disabled
end


def puts! args
  puts '+++ +++'
  puts args.inspect
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

def setup_cities
  City.all.each { |c| c.remove }
  
  @sf = FactoryGirl.create :sf
  @city = FactoryGirl.create :city
  @rio = FactoryGirl.create :rio
  @nyc = FactoryGirl.create :nyc

  [ @sf, @city, @rio, @nyc ].each do |city|
    ph = Photo.all[0] || Photo.new
    ph.user = User.all.first
    if ph.save
      ;
    else
      puts! ph.errors
    end
    city.profile_photo = ph
    city.is_feature = true
    if city.save
      ;
    else
      puts! city.errors
    end
  end

  feature_cities = City.all.features
  feature_cities.each do |city|
    assert_not_nil city.profile_photo
  end
  
end

def setup_photos
  url = 'http://s3.amazonaws.com/ish-assets/loginWithFacebook.png'

  if Photo.all.length < C.n_photos
    (0..C.n_photos).each do |i|
      new = Photo.new
      new.photo = open(url)
      new.user = User.all.first || User.create( :username => 'aaa', :name => 'Name' )
      flag = new.save
      if !flag
        puts! new.errors
      end
    end
  end
  
end