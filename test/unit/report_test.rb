

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  
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
    
    r = Report.new :name => 'lalala'
    assert r.save
    
    new = Report.where( :name => r.name ).first
    assert !new.name_seo.blank?
    assert_equal r.name, new.name_seo
    
  end
  
end
