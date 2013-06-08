require 'test_helper'
require 'wikitravel_tasks'
class WikitravelTasksTest < ActiveSupport::TestCase
  setup do
    User.all.each { |u| u.remove }
    @anon = FactoryGirl.create :anon
    Report.clear
    setup_sites
    City.all.each { |c| c.remove }
  end

  test 'random page to new report, newsitem of site, newsitem of city.' do
    city = FactoryGirl.create :maputo
    @site = Site.where( :domain => 'travel-guide.mobi', :lang => :en ).first
    n_reports = @site.reports.length
    assert_equal 0, @site.newsitems.length
    city = City.where( :name => 'Maputo' ).first
    assert_not_nil city
    n_city_items = city.newsitems.length
    n_site_items = @site.newsitems.length

    WikitravelTasks.random_page_to_newsitem
    assert_equal n_site_items+1,  Site.find(@site.id).newsitems.length
    assert_equal n_reports+1,     Site.find(@site.id).reports.length
    assert_equal n_city_items+1,  City.find(city.id).newsitems.length
  end

  test 'parse list of pages' do
    WikitravelPage.clear
    assert_equal 0, WikitravelPage.all.length
    WikitravelTasks.parse_list_of_pages 'wikitravel.org-popular-pages-test.htm'
    assert_equal 3, WikitravelPage.all.length
    # twice, because duplicates should be silently muted.
    WikitravelTasks.parse_list_of_pages 'wikitravel.org-popular-pages-test.htm'
    assert_equal 3, WikitravelPage.all.length
  end


end
