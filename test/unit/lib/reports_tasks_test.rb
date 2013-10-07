require 'test_helper'
require 'reports_tasks'

class ReportsTasksTest < ActiveSupport::TestCase
  
  setup do
    User.all.each { |u| u.remove }
    @anon = FactoryGirl.create :anon

    Report.clear

    setup_sites
  end

  test 'parse reuters tech feed' do
    site = Site.where( :domain => 'piousbox.com', :lang => :en ).first
    assert_not_nil site
    n_newsitems_old = site.newsitems.length
    n_reports_old = Report.all.length

    ReportsTasks.parse_reuters_technology_rss

    n_reports_new = Report.all.length
    assert( n_reports_new != n_reports_old )
    n_newsitems_new = Site.find(site.id).newsitems.length
    assert( n_newsitems_new != n_newsitems_old )
  end

end
