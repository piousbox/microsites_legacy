
require 'spec_helper'


describe IshController do

  before :each do
    User.all.each { |u| u.remove }
    Day.all.each { |d| d.remove }
  end

  describe 'home' do
    
    it 'should render ISh layout' do
      get :home
      response.should be_success
      response.should render_template('layouts/ish')
    end

    it 'should be sane' do
      true.should_not eql false
    end
    
  end
  
end
