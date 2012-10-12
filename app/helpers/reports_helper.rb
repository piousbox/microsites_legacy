

module ReportsHelper
  
  def report_path r
    "/reports/view/#{r.name_seo}"
  end
  
end