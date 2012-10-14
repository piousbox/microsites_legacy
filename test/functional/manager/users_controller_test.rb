#
#require 'test_helper'
#
#class Manager::UsersControllerTest < ActionController::TestCase
#  
#  setup do
#    @user = users(:one)
#    @admin = users(:admin)
#    @manager = users :manager
#    
#    @r = reports(:one)
#  end
#  
#  test 'get dashboard' do
#    get :dashboard
#    assert_response :redirect
#    
#    sign_in :user, @manager
#    
#    get :dashboard
#    assert_response :success
#    assert_template :dashboard
#    
#    assert_contains t('venues.list')
#    
#    assert_contains t('g.mark_features')
#    
#  end
#
#end
