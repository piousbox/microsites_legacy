


require 'test_helper'
require 'tags_tasks'

class TagsTasksTest < ActiveSupport::TestCase
  
  test 'to_mongodb' do
    # there are no no_tags
    new_tags = NoTag.all
    new_tags.each {|t| t.remove}
    assert_equal 0, NoTag.all.length
    
    old_tags = Tag.find :all
    
    #
    # churn!
    #
    TagsTasks.to_mongodb
    
    new = NoTag.all
    assert_equal new.length, old_tags.length
    
    old_tags.each_with_index do |old, idx|
      assert_equal old[:name_seo], new[idx][:name_seo]
    end
    
  end

end
