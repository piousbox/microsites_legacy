

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
  
  test 'no_parent' do
    ns = Tag.no_parent
    assert ns.length > 1
    ns.each do |n|
      assert_nil n.parent_tag
    end
    
  end
  
  test 'can create two tags with empty domains' do
    t = Tag.create :name => 'asdfl'
    assert t.save
    tt = Tag.create(:name => 'asdfl')
    assert !tt.save
    ttt = Tag.create :name => 'asdflsfag'
    assert ttt.save
  end
  
  test 'scope no_domain' do
    no_domain = Tag.no_domain
    assert no_domain.length > 1
    no_domain.each do |nnn|
      assert nnn.domain.blank?
    end
  end
  
end
