
require 'test_helper'
require 'users_tasks'

class UsersTasksTest < ActiveSupport::TestCase

  setup do

  end

  test 'import old' do
    User.clear
    UsersTasks.import_old

    assert User.all.length > 10
    assert_equal 'User', User.where( :email => 'krystymcintyre@gmail.com' ).first.class.name

  end
end
