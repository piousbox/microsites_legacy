require 'spec_helper'
describe 'reports', :type => :feature do
  before :each do
    setup_sites
    @site = Site.all.first
    @site.domain = 'example.com'
    @site.save

    Venue.all.each { |v| v.remove }
    @venue_1 = FactoryGirl.create :venue

    Report.clear
    @report = FactoryGirl.create :r1
    @report.x = '0.2'
    @report.y = '1.5'
    @report.venues << @venue_1
    @report.save
  end

  it 'renders map on show if there are venues associated with the report' do
    visit "/en/reports/view/#{@report.name_seo}"
    page.should have_css('#reports_show_canvas')
  end

  it 'renders no map if there are no venues' do
    ;
  end

end
