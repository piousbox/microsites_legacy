
require 'spec_helper'


describe AddressbookitemsController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
    Addressbookitem.all.each { |d| d.remove }

    @user = FactoryGirl.create :user
    sign_in :user, @user
    
  end

  describe 'new' do
    it 'should get new' do
      get :new
      response.should be_success
      assigns(:addressbookitem).should_not be nil
    end

    it 'should post to create' do
      Addressbookitem.all.length.should eql 0

      a = { :name => 'blah blah 3' }
      post :create, :addressbookitem => a

      result = Addressbookitem.where( :name => a[:name] ).first
      result.class.name.should eql 'Addressbookitem'
      result.user.username.should eql @user.username
      result.user.username.class.name.should eql 'String'

      Addressbookitem.all.length.should eql 1
    end
  end

  describe 'search' do
    it 'should search' do
      keyword = 'a'

      post :index, :addressbookitem => { :name => keyword }
      assert_template 'addressbookitems/index'
      as = assigns(:addressbookitems)
      as.each do |a|
        a.name.include?( keyword ).should be true
      end
      
    end
  end
end
