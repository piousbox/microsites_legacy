require 'test_helper'

class EdgeTest < ActiveSupport::TestCase

  setup do
    Edge.all.each { |e| e.remove }
    Node.all.each { |n| n.remove }
    
  end

  test 'fields timestamps' do
    e = Edge.new
    assert e.save
    assert_not_nil e.created_at
  end

  test 'to-from relationships' do
    e_1 = Edge.create
    e_2 = Edge.create

    n_1 = Node.create
    n_2 = Node.create

    e_1.to = n_1
    e_1.from = n_2
    assert e_1.save

    assert_equal e_1, n_1.in
    assert_equal e_1, n_2.out
    
  end

  test 'sanity' do
    assert false, 'todo'
  end

end


