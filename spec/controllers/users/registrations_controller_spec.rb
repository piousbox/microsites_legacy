require 'spec_helper'
describe Users::RegistrationsController do
  before :each do
    User.all.each { |u| u.remove }
    @user = FactoryGirl.create :user
    @manager = FactoryGirl.create :manager
    @piousbox = FactoryGirl.create :piousbox

    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'Normal' do
    it '#new' do
      # @request.env['HTTP_REFERRER'] = 'http://test.host/users/show/piousbox?layout=application&locale=en'
      get :new
      response.should be_success
    end
  end

end
