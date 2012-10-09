


require 'test_helper'
require 'cities_tasks'

class TagsTasksTest < ActiveSupport::TestCase
  
  setup do
    @sf = FactoryGirl.create :sf
    @sf = FactoryGirl.create :city
    
    @city1 = SqlCity.create :name => 'city name 1', :name_seo => 'city_name_1', :country_id => 2, :user_id => 2
    @city2 = SqlCity.create :name => 'city name 2', :name_seo => 'city_name_2', :country_id => 2, :user_id => 2
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

end
