


require 'test_helper'
require 'reports_tasks'

class ReportsTasksTest < ActiveSupport::TestCase
  
  test 'to_mongodb' do
    # there are no no_tags
    new_reports = NoReport.all
    new_reports.each {|t| t.remove}
    assert_equal 0, NoReport.all.length
    
    old_reports = Report.find :all
    
    #
    # churn!
    #
    ReportsTasks.to_mongodb
    
    new = NoReport.all
    assert_equal new.length, old_reports.length
    
    old_reports.each_with_index do |old, idx|
      assert_equal old[:name_seo], new[idx][:name_seo]
    end
    
  end

end
