
require 'test_helper'
require 'tags_tasks'

class TagsTasksTest < ActiveSupport::TestCase

  test 'name_to_name_en' do
    assert_equal true, true
  end
  
#  test 'to_mongoid' do
#    # there are no no_tags
#    new_tags = Tag.all
#    new_tags.each {|t| t.remove}
#    assert_equal 0, Tag.all.length
#
#    old_tags = SqlTag.find :all
#
#    #
#    # churn!
#    #
#    TagsTasks.to_mongoid
#
#    new = Tag.all
#    assert_equal new.length, old_tags.length
#
#    old_tags.each_with_index do |old, idx|
#      assert_equal old[:name_seo], new[idx][:name_seo]
#    end
#
#  end

end
