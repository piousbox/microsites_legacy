

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
  setup do
    clear_tags
    clear_reports
    
    # @main_tag = FactoryGirl.create :tag
    
    @r1 = FactoryGirl.create :r1
    @r2 = FactoryGirl.create :r2
    @r3 = FactoryGirl.create :r3
    
  end
  
  test 'default values' do
    
    r = Report.where( :name => 'blah' ).each {|rr| rr.remove }
    
    # public, non-feature, non-trash
    r = Report.new
    r.name = 'blah'
    r.save
    
    results = Report.where( :name => 'blah' )
    assert_equal 1, results.length
    result = results[0]
    assert result.is_public
    assert !result.is_feature
    assert !result.is_trash
    
  end
  
  test 'automatic name_seo' do
    clear_reports
    
    r = Report.new :name => 'lal ala.'
    assert r.save
    
    new = Report.where( :name => r.name ).first
    assert !new.name_seo.blank?
    assert_equal 'lal-ala', new.name_seo
    
  end
  
  test 'ordering by created-at for homepage' do
    # Tag.all.each { |t| puts! t }    
    # Report.all.each { |r| puts! r }

    result = Report.for_homepage :page => '1',
      :main_tag => @main_tag
    assert result.length > 2
    result.each_with_index do |r, idx|
      break if idx + 1 == result.length
        
      assert_not_nil result[idx][:created_at]
      assert result[idx][:created_at] >= result[idx][:created_at]
    end
  end
  
  test 'not_tagged' do
    ns = Report.not_tagged
    assert ns.length > 1
    ns.each do |n|
      assert_nil n.tag
    end
  end
  
end
