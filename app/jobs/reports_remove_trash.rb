
class ReportsRemoveTrash

  @queue = :standard_queue

  def self.perform args = {}
    ReportsTasks.empty_trash
  end

end
