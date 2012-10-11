

module AppModel
  
#  validates :name, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
#  validates :name_seo, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
	
	def list conditions = { :is_trash => 0}
		out = find(:all, :conditions => conditions, :order => 'name asc' )
		[['No Parent', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
  def list_nontrash
    out = find(:all, :order => 'name asc' )
		[['No Parent', nil]] + out.map { |item| [ item.name, item.id ] }
  end
  
  def list_no_trash
    list_nontrash
  end

	def list_mine user_id
		out = find(:all, :conditions => { :is_trash => 0, :user_id => user_id },
			:order => 'name asc' )
		[['No Parent', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
  @n_features = 4
  def self.n_features
    4
  end
  
  def features n_features = nil
    n_features ||= @n_features
    
    find(:all, :conditions => { :is_feature => 1, :is_trash => 0, :is_public => 1 },
      :order => 'name asc',
      :limit => n_features
    )
  end

	def random_string length = 5
		(0...length).map{65.+(rand(25)).chr}.join
	end
  
  def per_features_page
    50
  end

end