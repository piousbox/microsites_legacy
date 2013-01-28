
require 'spec_helper'

describe UsersController do
  
  before :each do
    User.all.each { |d| d.remove }
    Tag.all.each { |d| d.remove }
    Report.all.each { |r| r.remove }

    @user = FactoryGirl.create :user
    @tag = FactoryGirl.create :user_tag
    @r1 = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
    @r1.tag = @tag && @r1.save
    @r1.user = @user
    @r1.save
    @r2.tag = @tag && @r2.save
    @r2.user = @user
    @r2.save
    @r3.tag = @tag && @r3.save
    @r3.user = @user
    @r3.save
  end
  
  describe 'reports' do
    it 'should show reports' do
      get :reports, :username => @user.username
      response.should be_success
      response.should render_template(:reports)
      rs = assigns(:reports)
      rs.should_not be nil
    end

    it 'should show one report' do
      get :report, :name_seo => @user.reports.first.name_seo, :username => @user.username
      response.should be_success
      assigns( :report ).should_not eql nil
    end
  end

  describe 'galleries' do
    it 'should list galleries' do
      get :galleries, :username => @user.username
      response.should be_success
      assigns( :galleries ).should_not eql nil
    end

    it 'should show gallery' do
      get :gallery, :username => @user.username, :galleryname => @user.galleries.first.galleryname
      response.should be_success
      assigns( :gallery ).should_not eql nil
    end
  end

end
