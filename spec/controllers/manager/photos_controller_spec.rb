
require 'spec_helper'

describe Manager::PhotosController do

  before :each do
    User.all.each { |u| u.remove }
    @admin = FactoryGirl.create :admin
    sign_in :user, @admin

  end

  describe 'update' do
    it 'should be updateable via json' do
      Gallery.all.each { |g| g.remove }
      @g1 = FactoryGirl.create :gallery
      @g2 = FactoryGirl.create :g2
      @photo = FactoryGirl.create :photo
      @photo.gallery = @g1
      @photo.save
      post :update, :id => @photo.id, :photo => { :gallery_id => @g2.id }, :format => :json
      result = JSON.parse( response.body )
      response.should be_success
      result = Photo.find( @photo.id )
      result.gallery.name.should eql @g2.name
    end
  end

end
