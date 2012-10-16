


require 'test_helper'
require 'cities_tasks'

class TagsTasksTest < ActiveSupport::TestCase
  
  setup do
    @sf = FactoryGirl.create :sf
    @city = FactoryGirl.create :city
    
    @city1 = SqlCity.create :name => 'city name 1', :name_seo => 'city_name_1', :country_id => 2, :user_id => 2
    @city2 = SqlCity.create :name => 'city name 2', :name_seo => 'city_name_2', :country_id => 2, :user_id => 2
    @r11 = SqlReport.create :name => 'blah 1', :name_seo => 'blah_1', :city_id => @city1.id
    @r12 = SqlReport.create :name => 'blah 2', :name_seo => 'blah_2', :city_id => @city1.id
    @r21 = SqlReport.create :name => 'blah 3', :name_seo => 'blah_3', :city_id => @city2.id
    @r22 = SqlReport.create :name => 'blah 4', :name_seo => 'blah_4', :city_id => @city2.id
    
    @rs = []
    [ :r5, :r6, :r7, :r8 ].each do |rr|
      r_temp = FactoryGirl.build rr
      if Report.where( :name_seo => r_temp.name_seo ).first.blank?
        r_temp.save
      end
    end
    
  end
  
  test 'to_mongoid' do
    assert false, 'fail'
    
  end
  

end
