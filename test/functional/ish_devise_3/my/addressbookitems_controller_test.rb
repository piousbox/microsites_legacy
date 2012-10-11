require 'test_helper'

class My::AddressbookitemsControllerTest < ActionController::TestCase
  
  setup do
    @addressbookitem = addressbookitems(:one)
		@addritem_1 = { :date => '2011-01-01', :cities_user_id => 5,
			:created_at => '0000-00-00', :updated_at => '0000-00-00' }
    @user = users(:one)
  end
  
#  test "should get index" do
#    get :index
#    assert_response :redirect
#    assert_redirected_to sign_in_path
#
#    sign_in :user, @user
#    get :index
#    assert_response :success
#    items = assigns(:addressbookitems)
#    assert_not_nil items
#
#    items.each_with_index do |i, idx|
#      assert_equal false, i[:is_trash], 'no trash addritems is allowed in my index'
#      assert_equal @user.id, i[:user_id], 'only my addritems should be in my index'
#      if idx + 1 != items.length
#        assert items[idx][:name] <= items[idx+1][:name], 'alphabetic order by name'
#      end
#    end
#
#  end
#
#  test "should get new" do
#    get :new
#    assert_response :redirect
#
#    sign_in :user, @user
#
#    get :new
#    assert_response :success
#  end
#
#  test "one user should not be able to create two addritems with the same name" do
#    addritem_name = "1frs3e"
#    addritem1 = @addritem_1
#    addritem2 = @addritem_1
#		addritem1[:name] = addritem_name
#		addritem2[:name] = addritem_name
#
#    result = Addressbookitem.find_all_by_name addritem_name
#    assert_equal 0, result.length
#
#    sign_in :user, @user
#
#    post :create, :addressbookitem => addritem1
#    post :create, :addressbookitem => addritem2
#    result = Addressbookitem.find_all_by_name addritem_name
#    assert_equal 1, result.length
#    assert_equal @user.id, result[0][:user_id]
#  end
#
#  test "should create addressbookitem" do
#    addritem = @addritem_1
#		addritem[:name] = 'name 5'
#
#    post :create, :addressbookitem => addritem
#    assert_response :redirect
#
#    sign_in :user, @user
#
#    assert_difference('Addressbookitem.count') do
#      post :create, :addressbookitem => addritem
#    end
#    result = Addressbookitem.find_by_name(addritem[:name  ])
#    assert_equal @user.id, result[:user_id]
#
#    assert_response :redirect
#  end
#
#  test "should show addressbookitem" do
#    get :show, :id => @addressbookitem.to_param
#    assert_response :redirect
#
#    sign_in :user, @user
#
#    get :show, :id => @addressbookitem.to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @addressbookitem.to_param
#    assert_response :redirect
#
#    sign_in :user, @user
#
#    get :edit, :id => @addressbookitem.to_param
#    assert_response :success
#  end
#
#  test "should update addressbookitem" do
#    put :update, :id => @addressbookitem.to_param, :addressbookitem => @addressbookitem.attributes
#    assert_redirected_to sign_in_path
#
#    sign_in :user, @user
#
#    put :update, :id => @addressbookitem.to_param, :addressbookitem => @addressbookitem.attributes
#    assert_redirected_to addressbookitem_path(assigns(:addressbookitem))
#  end
#
#  test "should destroy addressbookitem" do
#		# do sign in
#    sign_in :user, @user
#
#    result = Addressbookitem.find_by_name @addressbookitem.name
#    assert_equal false, result[:is_trash]
#
#    delete :destroy, :id => @addressbookitem.to_param
#
#    result = Addressbookitem.find_by_name @addressbookitem.name
#    assert_equal true, result[:is_trash]
#
#    assert_redirected_to my_addressbookitems_path
#  end
end
