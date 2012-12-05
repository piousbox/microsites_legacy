


require 'test_helper'
require 'reports_tasks'

class ReportsTasksTest < ActiveSupport::TestCase
  
  setup do
    # nothing
    
  end
  
#  test 'migrate picture' do
#    old_reports = SqlReport.find( :all,
#      :conditions => [ 'photo_file_name is not null' ]
#    )
#    assert old_reports.length > 1
#    
#    old_reports.each do |old_report|
#      new_report = Report.where( :name_seo => old_report.name_seo ).first
#      begin
#        new_report.image.remove
#      rescue; end
#      assert new_report.save
#      assert new_report.image.blank?
#    end
#    
#    #
#    # Churn!
#    #
#    ReportsTasks.attached_photos_to_mongoid
#    
#    old_reports.each do |old_report|
#      url = old_report.photo.url(:original)
#      assert_not_nil url
#      new_image = Photo.new
#      new_image.photo = open(url)
#      assert new_image.save
#      
#      new_report = Report.where( :name_seo => old_report.name_seo ).first
#      new_report.photo = new_image
#      assert new_report.save
#    end
#    
#  end
#
#  test 'to_mongodb' do
#    # there are no no_tags
#    new_reports = Report.all
#    new_reports.each {|t| t.remove}
#    assert_equal 0, Report.all.length
#
#    old_reports = SqlReport.find :all
#
#    #
#    # churn!
#    #
#    ReportsTasks.to_mongoid
#
#    new = Report.all
#    assert_equal new.length, old_reports.length
#
#    old_reports.each_with_index do |old, idx|
#      assert_equal old[:name_seo], new[idx][:name_seo]
#    end
#
#  end

end
