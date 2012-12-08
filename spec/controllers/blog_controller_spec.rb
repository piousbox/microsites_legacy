require 'spec_helper'

describe BlogController do

  before :each do
    City.all.each { |u| u.remove }
    City.create :name => 'San Francisco', :cityname => 'San_Francisco'
  end

  describe 'blog' do
    it 'should index' do
      get :index
      response.should render_template('index')
    end
    
    it 'should search' do
      get :index, :keyword => 'wha'
      response.should be_success
      response.should render_template('index')
    end

  end
end
