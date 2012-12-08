require 'spec_helper'

describe BlogController do

  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'
  end

  describe 'blog' do
    it 'should search' do
      get :search, :keyword => 'wha'
      response.should be_success
      response.should render_template('index')
    end

  end
end
