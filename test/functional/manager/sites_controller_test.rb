
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

  end

  test 'get edit' do
    get :edit, :id => @site.id
    assert_response :success

  end

  test 'post update' do
    site = {}
    post :update, :id => @site.id, :site => site

  end
  
end
