require 'test_helper'

class My::TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
    @user = users(:user)
    @admin = users(:admin)
  end

	# the namespace 'my' will not be used at all.

#  test "should get index" do
#    sign_in :user, @user
#
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:active_todos)
#    assert_equal 0, assigns(:active_todos)[0][:is_done]
#
#    assert_not_nil assigns(:inactive_todos)
#    assert_equal 1, assigns(:inactive_todos)[0][:is_done]
#  end
#
#  test "should get new" do
#    sign_in :user, @user
#
#    get :new
#    assert_response :success
#  end
#
#  test "should create todo" do
#    sign_in :user, @admin # user could not do this, user already maxed out on allowed active todos.
#
#    assert_difference('Todo.count') do
#      post :create, :todo => @todo.attributes
#    end
#
#    assert_redirected_to my_todo_path(assigns(:todo))
#  end
#
#  test "should show todo" do
#    sign_in :user, @user
#
#    get :show, :id => 3
#    assert_response :success
#    assert_not_nil assigns(:todo)
#  end
#
#  test "should get edit" do
#    sign_in :user, @admin
#
#    get :edit, :id => 4
#    assert_response :success
#  end
#
#  test "should update todo" do
#    sign_in :user, @user
#
#    put :update, :id => @todo.to_param, :todo => @todo.attributes
#    assert_response :redirect
#  end
#
#  test "should set user_id upon create" do
#		todo = {:name => 'asdfq3rf123', :date_start => '0000-00-00'}
#
#		post :create, :todo => todo
#		assert_response :redirect
#
#		sign_in :user, @admin
#
#		post :create, :todo => todo
#		assert_redirected_to my_todo_path(assigns(:todo))
#		# check user id
#		result = Todo.find_by_name todo[:name]
#		assert_not_nil result
#		assert_equal @admin.id, result[:user_id], 'user_id must be saved upon create'
#	end
#
#  test "should not be able to save more than 5 active ones" do
#    sign_in :user, @user # user id 4
#
#    old_todos = Todo.find(:all, :conditions => { :user_id => 4, :is_done => 0, :is_trash => 0 } )
#
#    post :create, :todo => { :name => 'fake name', :descr => 'fake descr' }
#    new_todos = Todo.find(:all, :conditions => { :user_id => 4, :is_done => 0, :is_trash => 0 } )
#    assert_equal old_todos, new_todos, 'new todo could not be saved b/c there are already 5 active ones'
#
#    Todo.delete(8)
#
#    assert_difference('Todo.count') do
#      post :create, :todo => { :name => 'fake name', :descr => 'fake descr' }
#    end
#
#  end
end
