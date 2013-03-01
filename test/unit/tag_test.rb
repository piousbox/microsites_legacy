
require 'test_helper'

class TagTest < ActiveSupport::TestCase

  setup do
    Tag.clear
    FactoryGirl.create :tag1
    FactoryGirl.create :tag2
    
  end

  test 'automatic name_seo' do
    r = Tag.new :name_en => 'lalala'
    assert r.save
    
    new = Tag.where( :name_en => r.name_en ).first
    assert !new.name_seo.blank?
    assert_equal r.name_en, new.name_seo
  end
  
  test 'no_parent' do
    ns = Tag.no_parent
    assert ns.length > 1
    ns.each do |n|
      assert_nil n.parent_tag
    end
  end
  
  test 'can create two tags with empty domains' do
    t = Tag.create :name_en => 'asdfl', :name_seo => 'a'
    assert t.save
    tt = Tag.create :name_en => 'asdfl', :name_seo => 'a'
    assert !tt.save
    ttt = Tag.create :name_en => 'asdfl', :name_seo => 'aa'
    assert ttt.save
  end
  
end
