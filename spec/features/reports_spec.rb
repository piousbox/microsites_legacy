require 'spec_helper'
describe 'reports', :type => :feature do
  before :each do
    Report.all.each { |r| r.remove }
    @report = FactoryGirl.create :report

    Venue.all.each { |v| v.remove}
    @venue = FactoryGirl.create :venue

  end

  it 'renders map on show if there are venues associated with the report' do
    visit "/reports/view/#{@report.name_seo}"
    page.should have_css('.reports_show_canvas')
  end

  it 'renders no map if there are no venues' do
    ;
  end

end
