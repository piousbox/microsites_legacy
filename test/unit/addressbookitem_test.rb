require 'test_helper'

class AddressbookitemTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end
  
#  test "find mine" do
#    result = Addressbookitem.find_mine(1)
#    result.each_with_index do |i, idx|
#      assert_equal 0, i[:is_trash]
#      assert_equal @user.id, i[:user_id], 'only my addritems should be in my index'
#      if idx + 1 != result.length
#        assert result[idx][:name] <= result[idx+1][:name], 'alphabetic order by name'
#      end
#    end
#  end
#        
#  test "different users should be able to create two addritems with the same name" do
#    addritem_name = "1frs3eaaa"
#    user_id_1 = 556
#    user_id_2 = 557
#    
#    result = Addressbookitem.find_all_by_name addritem_name
#    assert_equal 0, result.length  
#    
#    addritem1 = Addressbookitem.new
#    addritem1[:name] = addritem_name
#		addritem1[:name_seo] = addritem_name
#    addritem1[:user_id] = user_id_1
#		addritem1[:date] = '2011-01-01'
#		addritem1[:cities_user_id] = 5
#    addritem1.save 
#    
#    addritem2 = Addressbookitem.new
#    addritem2[:name] = addritem_name
#		addritem2[:name_seo] = addritem_name
#    addritem2[:user_id] = user_id_2
#		addritem2[:date] = '2011-01-01'
#		addritem2[:cities_user_id] = 5
#    addritem2.save
#    
#    result = Addressbookitem.find_all_by_name addritem_name
#    assert_equal 2, result.length
#    assert_equal user_id_1, result[0][:user_id]
#    assert_equal user_id_2, result[1][:user_id]
#  end
end
