require 'spec_helper'

describe Manager::CitiesController do

  before :each do
    City.all.each { |c| c.remove }
    Report.all.each { |c| c.remove }
    Tag.all.each { |c| c.remove }
    Gallery.all.each { |g| g.remove }
    User.all.each { |c| c.remove }

    @user = User.all[0]
    @admin = FactoryGirl.create :admin

    @city = FactoryGirl.create :rio
    n = Newsitem.new :descr => 'first newsitem' 
    @city.newsitems << n

    @r1 = FactoryGirl.create :r1
    @r1.city = @city
    @r1.save

    @r9 = FactoryGirl.create :r9
    @r9.city = @city
    @r9.save


    @g = Gallery.create :name => 'a', :galleryname => 'bb', :user => User.all[0]

    sign_in :user, @admin

    setup_sites

  end

  describe 'change_profile_pic' do
    it 'can POST' do
      photo = { :name => 'temp naame' }

      post :change_profile_pic, :id => @city.id, :photo => photo
      # assert_response :redirect
      city = City.find(@city.id)
      city.profile_photo.name.should eql photo[:name]
    end
  end
  
  describe 'features' do
    it 'should GET feature' do
      get :new_feature, :city_id => @city.id
      response.should be_success
    end
    
#    it 'creating a feature report updates city features' do
#      false.should eql true
#    end
#
#    it 'creating feature gallery updates city features' do
#      false.should eql true
#    end

  end

  describe 'newsitems' do
    it 'should GET new newsitem' do
      get :new_newsitem, :city_id => @city.id
      response.should be_success
    end

    it 'should create new newsitem' do
      old_n_newsitems = @city.newsitems.length
      ( old_n_newsitems > 0 ).should eql true

      newsitem = { :descr => 'newsiten new descr' }

      post :create_newsitem, :city_id => @city.id, :newsitem => newsitem
      response.should be_redirect

      new_n_newsitems = City.find( @city.id ).newsitems.length
      ( new_n_newsitems - 1 ).should eql old_n_newsitems
    end

#    it 'adds newsitem for new public gallery' do
#      false.should eql true
#    end
#
#    it 'adds newsitem for new public report' do
#      false.should eql true
#    end
#
#    it 'adds newsitem for new public individual photo' do
#      false.should eql true
#    end
#
#    it 'adds newsitem for new public venue' do
#      false.should eql true
#    end

  end

end
