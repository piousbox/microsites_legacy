#require 'test_helper'
#
#class VideosControllerTest < ActionController::TestCase
#  
#  setup do
#    
#    @request.env['HTTP_REFERER'] = 'http://test.host/'
#    
#    @admin = FactoryGirl.create :admin
#    @user = FactoryGirl.create(:user)
#    @manager = FactoryGirl.create :manager
#    
#    @feature_video = Video.create :is_feature => 1, :name => 'tegs', :seo => 'bfrvsx', :youtube_url => 'rgvcdex'
#    
#    @venue = FactoryGirl.create :venue
#		
#    sign_in :user, @admin
#    
#  end
#  
#
#  test 'show' do
#    v = Video.first_feature
#    assert_not_nil v
#    
#    get :show, :id => v.id
#    assert_response :success
#    assert_not_nil assigns :video
#  end
#
#  test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:videos)
#  end
#  
#  test 'get new' do
#    get :new
#    assert_response :success, 'New videos are creatable by guests'
#    
#    sign_in :user, @user
#    
#    get :new
#    assert_response :success
#    assert_not_nil assigns :cities_list
#    assert_template :new
#  end
#  
#  test 'post new' do
#    sign_in :user, @admin
#    
#    @name = 'new video name'
#    
#    video = {}
#    video[:x] = 111
#    video[:y] = 222
#    video[:name] = @name + 'tegrfw'
#    video[:youtube_url] = 'btgrvcefdw'
#
#    post :create, :video => video
#    assert_response :success
#    
#    new_video = Video.where( :name => video[:name] ).first
#    
#    assert_not_nil new_video, 'Be able to create a new video.'
#    assert_equal video[:x], new_video[:x]
#    assert_equal @admin[:id], new_video[:user_id]
#    
#  end
#  
#  test 'get index' do
#    get :index
#    assert_response :success
#    
#    videos = assigns :videos
#    assert_not_nil videos
#    assert_equal 'Video', videos[0].class.name
#    
#    feature_videos = assigns :feature_videos
#    assert_not_nil feature_videos, 'Feature videos must be non-null'
#    assert feature_videos[0].is_a? Video
#
#  end
#
#end
