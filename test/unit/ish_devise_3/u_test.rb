
require 'test_helper'
require 'u'

class UtilsTest < ActiveSupport::TestCase
  
  
  test 'clean_name_seo' do
    a = Report.new
    a[:name] = 'a.b'
    
    old = Report.find_by_name a[:name]
    begin
      old.destory
    rescue; end
    
    old = Report.find_by_name_seo a[:name].to_slug
    begin 
      old.destroy
    rescue; end
    
    U.clean_name_seo a
    
    r = Report.find_by_name a[:name]
    assert_equal 'a-b', r[:name_seo]
    
    a.destroy
    
  end
  
end