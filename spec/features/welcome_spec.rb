require 'spec_helper'

#class ActionDispatch::IntegrationTest
#  include Capybara::DSL
#  Capybara.default_host = 'www.example.com'
#end

describe "manager welcome", :type => :feature do
  before :each do
    @dd = 'www.example.com'
    Site.all.each { |s| s.remove }
    @site = Site.create( :domain => @dd, :lang => 'en' )
    (0...16).each do |i|
      f = Feature.new :name => 'lalala'
      @site.features << f
    end
    @site.save
  end

  it "has commit message" do
    visit '/en/manager'
    page.should have_css('.latest-commit')
  end

end
