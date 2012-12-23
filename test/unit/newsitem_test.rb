
require 'test_helper'

class NewsitemTest < ActiveSupport::TestCase

  setup do
    #    @f = Fabricate :video
    #    @ff = Fabricate :video_feature

  end

  test 'is sane' do
    n = Newsitem.new
    assert_equal n.class.name, 'Newsitem'
  end

end


