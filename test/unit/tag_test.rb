

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
  test 'automatic name_seo' do
    clear_tags
    
    r = Tag.new :name => 'lalala'
    assert r.save
    
    new = Tag.where( :name => r.name ).first
    assert !new.name_seo.blank?
    assert_equal r.name, new.name_seo
    
  end
  
end
