
require 'spec_helper'

describe TagsController do

  before :each do
    Tag.all.each { |c| c.remove }

    User.all.each { |c| c.remove }
    @user = FactoryGirl.create :user
    @anon = FactoryGirl.create :anon
    sign_in :user, @user
    
  end

  describe 'new' do
    it 'does not create without recaptcha' do
      ReportsController.any_instance.expects(:verify_recaptcha).returns(false)
      sign_out :user
      session[:current_user] = nil
      n_old = Report.all.length
      report = { :name => '24twebfvsdfg', :name_seo => '1235fff', :descr => 'lssfllll' }
      post :create, :report => report
      n_new = Report.all.length
      ( n_new - n_old ).should eql 0
    end
  end

end


