require 'test_helper'

class Econ::NodeTest < ActiveSupport::TestCase

  setup do
    Node.all.each { |n| n.remove }
    
  end

  test 'fields timestamps' do
    n = Node.new
    assert n.save
    assert_not_nil n.created_at
    
  end

  test 'sanity' do
    assert false, 'todo'
  end

end


