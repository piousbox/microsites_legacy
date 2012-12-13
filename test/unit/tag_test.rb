

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
#  test 'index_small' do
#    result = Tag.index_small
#    assert_equal 1, result[0][:id]
#  end
#  
#  test 'features' do
#    
#    result = Tag.features 3
#    assert_equal 3, result.length
#    assert 1 == result[0][:is_feature] || true == result[0][:is_feature]
#    
#    result = Tag.features
#    assert_equal 4, result.length
#  end
  
  test 'automatic name_seo' do
    clear_tags
    
    r = Tag.new :name => 'lalala', :user => User.all.first
    assert r.save
    
    new = Tag.where( :name => r.name ).first
    assert !new.name_seo.blank?
    assert_equal r.name, new.name_seo
    
  end
  
  test 'update with empty domain' do
    ps = old_tags_with_blank_domain = Tag.where( :domain => '' )
    ps.each { |p| p.remove }
    
    name = 'blaskfgjaifg'
    aa = Tag.create :name => name,
      :domain => '', :user => User.all.first
    
    assert aa.save
    new = Tag.where( :name => name ).first
    assert_equal 'Tag', new.class.name
    assert_nil new.domain
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
  
  test 'scope no_domain' do
    no_domain = Tag.no_domain
    assert no_domain.length > 1
    no_domain.each do |nnn|
      assert nnn.domain.blank?
    end
  end
  
end
