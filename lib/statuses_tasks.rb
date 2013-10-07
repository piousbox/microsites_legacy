

class StatusesTasks
  
  def self.to_dictitems
    statuses = Status.find :all,
      :conditions => { :is_trash => 0 }
    
    statuses.each do |status|
      d = Dictionaryitem.new
      d[:descr] = status[:name]
      d[:user_id] = status[:user_id]
      d[:created_at] = status[:created_at]
      d[:updated_at] = status[:updated_at]
      d[:is_trash] = 0
      d[:is_public] = status[:is_public]
      d[:tag_id] = status[:tag_id]
      d.save
    end
  end
  
end