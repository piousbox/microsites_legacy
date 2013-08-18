
require 'spec_helper'

RSpec.configure do |c|
  c.filter_run_excluding :future_functionality => true
end

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

  describe 'new', :future_functionality => true do
    it 'GET' do
      sign_out :user
      get :new
      response.should be_redirect
      sign_in :user, @user
      get :new
      response.should render_template( 'videos/new' )
    end
  end

end
