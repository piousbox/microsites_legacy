
require 'test_helper'

class DayTest < ActiveSupport::TestCase
  
  setup do
    create_users
    
    Day.all.each{|d|d.remove}
    @d = FactoryGirl.create :day
    
  end
  
  test 'date must be present' do
    d = Day.all[0]
    assert_not_nil d.date
    assert_equal 'User', d.user.class.name
    
  end
  
  test 'cannot create day with same date' do
    dd = Day.new
    dd.date = @d.date
    dd.user = User.all[0]
    assert !dd.save
    dd.date = '0000-99-99'
    assert dd.save
  end
  
  test 'day validates' do
    u = User.all[0]
    hsh = { :date => '2012-01-11', :user => u, :a1 => 'a', :a2 => 'a2', :a3 => 'a3', :a4 => 'a4', :a5 => 'a5', :work => 'work', :dream => 'dream' }
    
    
    d = Day.new hsh.reject{ |k,v| k == :date }
    assert !d.save
    
    d = Day.new hsh.reject{ |k,v| k == :user }
    assert !d.save
    
    d = Day.new hsh.reject{ |k,v| :a1 == k || :a2 == k }
    assert d.save
    
  end

  test 'sanity' do
    #
    # make sure that edge and node and agent tests are there.
    #
    assert false, 'todo'
  end
  
end


