
ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test_extensions'
require "mocha/setup"
require "open-uri"

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

  assert_equal 0, City.all.where( :is_feature => true ).length
  
  [ @sf, @city, @rio, @nyc ].each_with_index do |city, idx|
    ph = Photo.all[idx] || Photo.new
    ph.user = User.all.first
    ph.save
    city.profile_photo = ph
    city.is_feature = true
    city.save
  end

  feature_cities = City.all.where( :is_feature => true )
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
      new.errors

    end
  end
end

def setup_sites
  Site.all.each { |s| s.remove }
  # note: It should only be piousbox.com and test.host
  FactoryGirl.create :test_site
  FactoryGirl.create :site_piousbox
  FactoryGirl.create :site_piousbox_ru
  FactoryGirl.create :site_piousbox_pt
  @site = Site.where( :domain => 'test.host', :lang => 'en' ).first
end

def setup_reports
  Report.clear
  @r1 = FactoryGirl.create :r1
end
