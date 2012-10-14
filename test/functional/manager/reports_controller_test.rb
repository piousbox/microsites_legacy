#
#require 'test_helper'
#
#class Manager::ReportsControllerTest < ActionController::TestCase
#  
#  setup do
#    @user = users(:one)
#    @admin = users(:admin)
#    @manager = users :manager
#    
#    @r = reports(:one)
#  end
#  
#  test 'get mark_features' do
#    assert_equal 2, @manager[:group_id]
#    
#    sign_in :user, @manager
#    
#    get :mark_features
#    assert_response :success
#    assert_template 'mark_features'
#    
#    reports = assigns :items
#    assert_not_nil reports
#    assert_not_nil reports[0].user
#    assert_not_nil reports[0].user.username
#   
#  end
#  
#  test 'post mark_features' do
#    sign_in :user, @manager
#    
#    one = Report.find(@r[:id])
#    assert_equal 1, one[:is_feature]
#    
#    post :mark_features, :id => 1, :is_feature => 0
#    
#    one = Report.find(@r[:id])
#    assert_equal 0, one[:is_feature]
#  end
#
#
#end
