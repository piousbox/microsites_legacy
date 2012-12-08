require 'spec_helper'

describe BlogController do

  before :each do
    @domain = 'blog.test.local'

    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'

    Report.all.each { |r| r.remove }
    @r = FactoryGirl.create :report_blog

    Site.all.each { |s| s.remove }
    @site = FactoryGirl.create :site_blog

    User.all.each { |s| s.remove }
    @user = FactoryGirl.create :user

  end

  describe 'blog' do
    it 'should show' do
      n = Report.where( :domain => @domain ).first.name_seo
      get :show, :name_seo => n
      response.should be_success
    end

    it 'should index' do
      get :index
      response.should render_template('index')
    end
    
    it 'should search' do
      get :index, :keyword => 'wha'
      response.should be_success
      response.should render_template('index')
    end

  end
end
