require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  
  test ".find_in_city" do
    result = Venue.find_in_city 22
    assert_not_nil result
    assert result.length > 2
  end
  
#  test '.weekly_in' do
#    result = Venue.weekly_in 22
#    result.each do |day|
#        assert((1 == day[1].is_public) || (true == day[1].is_public)) unless day[1].blank?
#        assert_equal 22, day[1][:city_id] unless day[1].blank?
#    end
#    
#  end
#  
#  test 'weekly in with venue_type_id' do
#    result = Venue.weekly_in 22, 5
#    result.each do |day|
#      assert_equal 5, day[1][:venue_type_id] unless day[1].blank?
#    end
#  end
  
end
