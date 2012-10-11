require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
		@admin = users(:admin)

		sign_in :user, @admin
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end
  
  test ".index_small" do
    get :index_small
    assert_response :success
    assert_not_nil assigns :idx_events
  end
  
  test 'venue should be saved' do
    name = 'unique name awertq34rtf'
    venue_id = 567890
    
    post :create, :event => { :name => name, :venue_id => venue_id, :date => '2012-02-02' }
    result = Event.find_by_name(name)
    assert_not_nil result
    assert_equal venue_id, result[:venue_id]
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show event" do
    
    assert_not_nil @event[:name_seo]
    
    get :show, :name_seo => @event[:name_seo]
    
    assert_response :success
    assert_template :show
    
  end

  test "should get edit" do
    get :edit, :id => @event.id
    assert_response :success
  end

  test "should update event" do
    put :update, :id => @event.id, :event => @event.attributes
    assert_redirected_to event_path(assigns(:event))
  end
end
