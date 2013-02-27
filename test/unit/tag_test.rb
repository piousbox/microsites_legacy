
require 'test_helper'

class TagTest < ActiveSupport::TestCase

  test 'automatic name_seo' do
    Tag.clear
    
    r = Tag.new :name => 'lalala', :user => User.all.first
    assert r.save
    
    new = Tag.where( :name => r.name ).first
    assert !new.name_seo.blank?
    assert_equal r.name, new.name_seo
    
  end
  
  test 'no_parent' do
    ns = Tag.no_parent
    assert ns.length > 1
    ns.each do |n|
      assert_nil n.parent_tag
    end
    
  end
  
  test 'can create two tags with empty domains' do
    t = Tag.create :name => 'asdfl', :user => User.all.first
    assert t.save
    tt = Tag.create(:name => 'asdfl', :user => User.all.first)
    assert !tt.save
    ttt = Tag.create :name => 'asdflsfag', :user => User.all.first
    assert ttt.save
  end
  
end
