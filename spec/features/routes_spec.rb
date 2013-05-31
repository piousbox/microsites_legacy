require 'spec_helper'

#class ActionDispatch::IntegrationTest
#  include Capybara::DSL
#  Capybara.default_host = 'www.example.com'
#end

describe "routes", :type => :feature do
  before :each do
    setup_sites
    @site = Site.where( :domain => 'www.example.com', :lang => :en ).first
    @site ||= FactoryGirl.create :site_example

  end

#  it "redirects to /:locale" do
#    visit '/blahblah'
#    response.should redirect_to('/en/blahblah')
#  end

end
