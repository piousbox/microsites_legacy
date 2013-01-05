require 'spec_helper'

describe Manager::UsersController do

  before :each do
    Tag.all.each { |c| c.remove }

    Gallery.all.each { |g| g.remove }

    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @admin = FactoryGirl.create :admin

    City.all.each { |c| c.remove }
    @city = FactoryGirl.create :rio

    Report.all.each { |c| c.remove }
    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save


    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    sign_in @admin

  end

  describe 'index' do
    it 'can do' do
      get :index
      response.should be_success
      response.should render_template 'index'
    end
  end

  describe 'edit' do
    it 'can show' do
      get :edit, :id => @user.id
      response.should render_template 'edit'
    end
  end

end
