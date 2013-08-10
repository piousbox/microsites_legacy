
require 'spec_helper'
describe Utils::UtilsController do

  before :each do
    Report.all.each { |c| c.remove }

    User.clear
    @user = FactoryGirl.create :user

    Gallery.all.each { |g| g.remove }
    @g = FactoryGirl.create :gallery
    @g1 = FactoryGirl.create :g1
    @g2 = FactoryGirl.create :g2

  end

  describe 'version' do
    it 'should show version' do
      get :version
      assert_response :success
    end
  end
end
