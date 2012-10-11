
require 'test_helper'
require 'total_ability'


class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @admin = users(:admin)

#    @admin = NoUser.create :email => 'gefsd@gefsd.com', :group_id => 1
#    @user = NoUser.create :email => 'gefsffd@gefsd.com', :group_id => 3
    
    sign_in :user, @admin
    
    @e = '6b4tgrv3cde@gmail.com'
    @name = 'GHJGHJK GHJKGHJK'
  end
  
  test 'passing old locales on sign_in' do
    @request.host = "ru.ish.com:3000"
    get :sign_in
    assert_response :redirect

  end
  
  test 'on login, @nome is present' do
    sign_out :user
    
    no = NoUser.new
    no.email = @e
    assert no.save
    
    u = User.create( :email => @e )
    assert u.save
    
    sign_in :user, u
    
    get :index
    nome = assigns :nome
    assert_not_nil nome
    assert_equal 'NoUser', nome.class.name
    
    assert no.remove
    assert u.destroy
  end
  
  test 'set_username' do
    
    get :set_username
    assert_response :success
  end
  
  test 'create new user' do
    

    # params
    email = "654rf@fmail.com"
    username = 'new_username'
    session["devise.facebook_data"] = { :info => { :email => email } }
    
    # clear
    NoUser.where( :email => email ).all.each { |u| u.remove }
    sign_out :user
    
    # old is empty
    old_sql = User.find_by_email email
    assert_nil old_sql
    old_no = NoUser.where( :email => email ).first
    assert_nil old_no
    
    # do it
    @controller = Users::OmniauthCallbacksController.new
    
    
    
    return
    
    
    
    get :facebook
    assert_response :redirect
    assert_redirected_to set_username_path
    
    new_sql = User.find_by_email email
    assert_equal 'User', new_sql.class.name
    new_no = NoUser.where( :email => email ).all
    assert_equal 1, new_no.length
    assert_equal 'NoUser', new_no[0].class.name
    
    assert user_signed_in?
    
    assert new_sql.destroy
    sign_out :user
    
    # now, try to create another time, but no_user already exists
    post :new, :username => username
    
    new_no = NoUser.where( :email => email ).all
    assert_equal 1, new_no.length
    
    new_no.remove
    
  end
  
  
  
  
  
  
  test 'a user without city should still display' do
    u = User.new
    u[:username] = 'trashy-qqq'
    u[:email] = 'nonexistent@gmail.com'
    assert u.save
    
    get :show, :username => u[:username]
    assert_response :success
    uu = assigns :user
    assert_not_nil uu
    assert_nil uu[:city_id]
  end

  test 'set city' do
    assert_nil session[:current_city]
    get :set_city
    assert_not_nil assigns :cities_list
    
    post :set_city, :user => { :city_id => 22 }
    
    assert_not_nil session[:current_city]
    assert_equal 22, session[:current_city][:id]
    assert_equal 'San Francisco', session[:current_city][:name]
  end

  test ".index_small" do
    get :index_small
    assert_response :success
    assert_not_nil assigns :idx_users
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
	
  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :redirect
    assert_not_nil assigns(:user)
    assert_redirected_to '/users/show/' + @user[:username]
  end
	
  test 'dashboard' do
    session[:current_city] = City.find(22)
    get :dashboard
    
    assert_response :success
    assert assigns :user
  end
  
  test 'edit scratchpad post' do
    
    user = User.find(@user[:id])
    user[:scratchpad] = ''
    user.save!
    
    old_scratchpad = User.find(@user[:id])[:scratchpad]
    assert_equal '', old_scratchpad
    
    post :edit_scratchpad, :scratchpad => 'blah blah 2'
    
    assert_response :redirect
    assert_redirected_to dashboard_path
    new_scratchpad = User.find(@admin[:id])[:scratchpad]
    assert_equal new_scratchpad, 'blah blah 2'
  end
  
  test 'edit scratchpad get' do
    get :edit_scratchpad
    assert_response :success
    assert_select 'textarea#scratchpad', @admin[:scratchpad]
  end
  
  test 'get reports html_data for a user' do
    
    get :reports_data, :reports_page => 1, :id => 1
    result_1 = assigns(:reports)
    assert_not_nil result_1
    
    get :reports_data, :reports_page => 2, :id => 1
    result_2 = assigns(:reports)
    assert_not_nil result_2
    
    assert result_1 != result_2
    
  end
  
  test 'get sign in' do
    
    sign_out :user
    @request.host = 'pt.ish.com:3000'
    get :sign_in
    assert_response :success
    assert_template :sign_in
    
    sign_out :user
    @request.host = 'ru.ish.com:3000'
    get :sign_in
    assert_response :redirect
    assert_redirected_to 'http://pt.ish.com:3000/users/sign_in'
    
  end
  
#  test "should get edit" do
#    get :edit, :id =>  @user.to_param
#    assert_response :redirect
#    
#    sign_in :user, @user
#    
#    get :edit, :id =>  @user.to_param
#    assert_response :success
#  end
#
#  test "should update user" do
#    put :update, :id =>  @user.to_param, :user => @user.attributes
#    assert_redirected_to sign_in_path
#    
#    sign_in :user, @user
#		
#    put :update, :id =>  @user.to_param, :user => @user.attributes
#    assert_redirected_to show_user_path(assigns(:user))
#  end
   

end
