
require 'test_helper'

class Manager::SitesControllerTest < ActionController::TestCase

  setup do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @admin = FactoryGirl.create :admin
    @manager = FactoryGirl.create :manager
    @anon = FactoryGirl.create :anon

    sign_in :user, @manager

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site_pi
    f = Feature.new
    f.name = 'simple name'
    @site.features << f

    @request.host = 'pi.local'
    
  end

  test 'get edit' do
    get :edit, :id => @site.id
    assert_response :success
    assert_not_nil assigns(:site)

  end

  test 'post update' do
    site = { :title => 'blah blah asdafff' }
    post :update, :id => @site.id, :site => site
    assert_response :redirect
    result = Site.find @site.id
    assert_equal site[:title], result.title

  end

  test 'update feature' do
    new_name = 'New Naaaaaa~~~!!!!!@@@@me'
    feature = { :name => new_name, :id => @site.features.all[0].id }
    site = { :id => @site.id }

    post :update_feature, :site_id => site[:id], :feature_id => feature[:id], :feature => feature
    assert_response :redirect
    result = Site.find( site[:id] ).features.find( feature[:id] )
    assert_equal new_name, result.name
    
  end
  
end
