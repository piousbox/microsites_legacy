require 'spec_helper'

# RSpec.configure do |c|
#   c.filter_run_excluding :future_functionality => true
# end

describe VideosController do
  before :each do
    User.all.each { |r| r.remove }
    @user = FactoryGirl.create :user

    Video.all.each { |v| v.remove }
    @v1 = FactoryGirl.create :v1
    @v2 = FactoryGirl.create :v2
    @v3 = FactoryGirl.create :v3

    setup_sites
  end

  describe 'show' do
    it 'should GET individual show' do
      get :show, :youtube_id => @v1.youtube_id
      response.should be_success
      response.should render_template('videos/show')
    end
  end

  describe 'index' do
    it 'should' do
      sign_out :user
      get :index
      response.should be_success
      vs = assigns(:videos)
      vs.length.should be > 0
    end
  end

  describe 'new/create' do
    it 'cannot create if not signed in' do
      sign_out :user
      get :new
      response.should be_redirect
      response.should redirect_to( 'http://test.host/en/users/sign_in' )
    end

    it 'GETs new' do
      sign_in :user, @user
      get :new
      response.should render_template( 'videos/new' )
      assigns( :video ).should_not eql nil
      assigns( :tags_list ).should_not eql nil
      assigns( :cities_list ).should_not eql nil
    end

    it 'POST create in-tag, in-city' do
      Video.all.each { |v| v.destroy }
      sign_in :user, @user

      video = { :tag_id => @tag.id, :city_id => @city.id, :youtube_id => 'Aaa', :is_public => true }
      post :create, :video => video

      Video.all.length.should eql 1
      result = Video.all.first
      result.city.name.should eql @city.name
      result.tag.name.should eql @tag.name
      result.is_public.should eql true
      result.user.username.should eql @user.username
    end

    it 'validates presence of youtube_id' do
      Video.all.each { |v| v.destroy }
      sign_in :user, @user

      video = { :tag_id => @tag.id, :city_id => @city.id, :is_public => true }
      post :create, :video => video
      
      Video.all.length.should eql 0
    end

  end

end
