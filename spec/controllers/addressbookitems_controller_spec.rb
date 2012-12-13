
require 'spec_helper'


describe AddressbookitemsController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
    Addressbookitem.all.each { |d| d.remove }

    @user = FactoryGirl.create :user
    sign_in :user, @user
    
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
