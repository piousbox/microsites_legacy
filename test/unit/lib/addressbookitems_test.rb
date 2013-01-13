
require 'test_helper'
require 'addressbookitems_tasks'

class AddressbookitemsTasksTest < ActiveSupport::TestCase

  setup do
    City.clear
    @sf = FactoryGirl.create :sf
    @city = FactoryGirl.create :city

    Addressbookitem.all.each { |a| a.remove }
    SqlAddressbookitem.find( :all ).each do |a|
      a.remove
    end
    
  end

  test 'to_mongodb' do

    sql_1 = SqlAddressbookitem.new
    sql_1.name = 'aaa'
    assert sql_1.save

    sql_2 = SqlAddressbookitem.new
    sql_2.name = 'aaa'
    assert sql_2.save

    AddressbookitemsTasks.to_mongoid

    assert_equal 1, Addressbookitem.all.length

  end

end
