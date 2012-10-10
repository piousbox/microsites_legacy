


require 'test_helper'
require 'cities_tasks'

class TagsTasksTest < ActiveSupport::TestCase
  
  setup do
    @sf = FactoryGirl.create :sf
    @sf = FactoryGirl.create :city
    
    @city1 = SqlCity.create :name => 'city name 1', :name_seo => 'city_name_1', :country_id => 2, :user_id => 2
    @city2 = SqlCity.create :name => 'city name 2', :name_seo => 'city_name_2', :country_id => 2, :user_id => 2
    @r11 = SqlReport.create :name => 'blah 1', :name_seo => 'blah_1', :city_id => @city1.id
    @r12 = SqlReport.create :name => 'blah 2', :name_seo => 'blah_2', :city_id => @city1.id
    @r21 = SqlReport.create :name => 'blah 3', :name_seo => 'blah_3', :city_id => @city2.id
    @r22 = SqlReport.create :name => 'blah 4', :name_seo => 'blah_4', :city_id => @city2.id
  end
  
  test 'to_mongodb' do
    # there are no cities
    new_cities = City.all
    new_cities.each {|t| t.remove}
    assert_equal 0, City.all.length
    
    olds = SqlCity.find :all
    assert olds.length > 1
    
    #
    # churn!
    #
    CitiesTasks.to_mongoid
    
    new = City.all
    assert_equal new.length, olds.length
    
    olds.each_with_index do |old, idx|
      assert_equal old[:name_seo], new[idx][:cityname]
    end
    
  end
  
  test 'attach new reports to new cities' do
    CitiesTasks.attach_reports_to_cities
    
    old_cities = SqlCity.find :all
    
    assert old_cities.length > 1
    old_cities.each do |old_city|
      assert old_city.reports.length > 1
      old_city.reports.each do |old_report|
        new_report = Report.where( :name_seo => old_report.name_seo ).first
        assert_not_nil new_report
        new_city = City.where( :cityname => old_report.city.name_seo ).first
        assert_not_nil new_city
        new_report.city = new_city
        assert new_report.save
      end
    end
  end

end
