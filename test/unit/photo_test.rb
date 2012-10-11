
require 'test_helper'
require "open-uri"

class PhotoTest < ActiveSupport::TestCase
  
  setup do
    #    @f = Fabricate :video
    #    @ff = Fabricate :video_feature
    
  end
  
  test 'can create new' do
    c = Photo.new
    assert_equal 'Photo', c.class.name
  end
  
  test 'can create picture from url' do
    url = 'http://s3.amazonaws.com/ish-assets/loginWithFacebook.png'
    new = Photo.new
    new.photo = open(url)
    assert new.save
    assert_not_nil new.photo.url(:small)
    
  end
  
end


