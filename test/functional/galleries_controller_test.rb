require 'test_helper'

class GalleriesControllerTest < ActionController::TestCase

  setup do
    User.all.each { |d| d.remove}
    @admin = FactoryGirl.create :admin
		sign_in :user, @admin

    Gallery.all.each { |g| g.remove }
    FactoryGirl.create :gallery
    FactoryGirl.create :g1
    FactoryGirl.create :g2
    FactoryGirl.create :g3

    setup_sites
    site = Site.where( :lang => 'en', :domain => 'test.host' ).first
    Gallery.all.each do |g|
      g.site = site
      g.save
    end
  end
  
  test 'index' do
    get :index
    assert_response :success
    assert( assigns(:galleries).length > 1 )
    assert_template 'galleries/index'
    assigns(:galleries).each_with_index do |gallery, idx|
      if idx + 1 == assigns(:galleries).length
        ;
      else
        assert gallery.created_at >= assigns(:galleries)[idx+1].created_at
      end
    end
  end
  
  test 'get new' do
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:venues_list)
  end

  test 'get edit' do
    get :edit, :id => Gallery.all.first.id
    assert_template :edit
    assert_not_nil assigns(:venues_list)
  end

end
