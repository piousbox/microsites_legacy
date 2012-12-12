
require 'spec_helper'


describe IshController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
  end

  describe 'home' do
    it 'should render' do
      get :home
      response.should be_success
      
    end

  end
  
end
