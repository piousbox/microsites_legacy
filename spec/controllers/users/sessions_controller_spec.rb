require 'spec_helper'
describe Users::SessionsController do
  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
    Addressbookitem.all.each { |d| d.remove }

    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager
    @piousbox = FactoryGirl.create :piousbox

    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'destroy' do
    it 'should redirect to a resume page after logging out from the resume' do
      @request.env['HTTP_REFERRER'] = 'http://test.host/users/show/piousbox?layout=application&locale=en'
      delete :destroy
#      response.should render_template('layouts/resume')
    end
  end

  describe 'create' do
    it 'logs you in' do
      session[:current_user].should eql nil
      post :create, :user => { :email => 'piousbox@gmail.com', :password => 'pass1234' }
      session[:current_user].should_not eql nil
    end
  end

end
