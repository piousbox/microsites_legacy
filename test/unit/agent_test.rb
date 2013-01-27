
require 'test_helper'

class AgentTest < ActiveSupport::TestCase

  setup do
    Agent.all.each { |a| a.remove}

  end

  test 'sanity' do
    assert false, 'todo'
  end

end


