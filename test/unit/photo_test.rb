
require 'test_helper'


class PhotoTest < ActiveSupport::TestCase
  
  setup do
    setup_users
    setup_sites
  end
  
  test 'can create new' do
    c = Photo.new
    assert_equal 'Photo', c.class.name
  end
  
  test 'can create picture from url' do
    url = 'http://s3.amazonaws.com/ish-assets/loginWithFacebook.png'
    new = Photo.new
    new.photo = open(url)
    new.user = User.all.first
    flag = new.save
    puts! new.errors unless flag
    assert flag
    assert_not_nil new.photo.url(:small)
    
  end
  
end


