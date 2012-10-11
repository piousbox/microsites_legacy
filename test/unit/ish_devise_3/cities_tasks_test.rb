


require 'test_helper'
require 'cities_tasks'

class TagsTasksTest < ActiveSupport::TestCase
  
  test 'to_mongodb' do
    # there are no cities
    new_cities = NoCity.all
    new_cities.each {|t| t.remove}
    assert_equal 0, NoCity.all.length
    
    olds = City.find :all
    assert olds.length > 1
    
    #
    # churn!
    #
    CitiesTasks.to_mongoid
    
    new = NoCity.all
    assert_equal new.length, olds.length
    
    olds.each_with_index do |old, idx|
      assert_equal old[:name_seo], new[idx][:cityname]
    end
    
  end

end
