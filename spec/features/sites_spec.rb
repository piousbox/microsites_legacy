require 'spec_helper'

#class ActionDispatch::IntegrationTest
#  include Capybara::DSL
#  Capybara.default_host = 'www.example.com'
#end

describe "sites", :type => :feature do
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

#  it "renders /features" do
#    s = Site.where( :domain => @dd, :lang => 'en' ).first
#    visit '/features'
#  end

end
