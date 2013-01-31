
require 'spec_helper'


describe AddressbookitemsController do

  before :each do
    
    Day.all.each { |d| d.remove }

    Addressbookitem.all.each { |d| d.remove }
    @addritems = FactoryGirl.create_list( :addressbookitem, 10 )

    User.all.each { |u| u.remove }
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
      n_old = Addressbookitem.all.length

      a = { :name => 'blah blah 3' }
      post :create, :addressbookitem => a

      result = Addressbookitem.where( :name => a[:name] ).first
      result.class.name.should eql 'Addressbookitem'
      result.user.username.should eql @user.username
      result.user.username.class.name.should eql 'String'

      Addressbookitem.all.length.should eql( n_old + 1 )
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

  describe 'index' do

    it 'should get index' do
      Addressbookitem.create :user => @user, :name => 'aaa'
      
      get :index
      as = assigns(:addressbookitems)
      as.to_a.length.should be > 0
      as.each do |a|
        a.user.should eql @user
      end
    end

  end
  
end
