
class SqlReport < ActiveRecord::Base
  
  extend AppModel

  self.table_name = 'reports'
  
#	belongs_to :user
	belongs_to :city, :foreign_key => :city_id, :class_name => 'SqlCity'
	
  validates :name_seo, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
  
#  has_many :reports_tags, :dependent => :destroy
#  has_many :tags, :through => :reports_tags
#  
#  has_many :galleries_reports
#  has_many :galleries, :through => :galleries_reports

  
	def self.recommended tags, limit = 4, this_report_id = 0, locale = 'en'
		tag_ids = [1] + tags.map do |t|
			t.id
		end
		
		reports_tags_ids = ReportsTag.find(:all,
			:conditions => ['tag_id in (?) and report_id != ?', tag_ids, this_report_id],
			:select => ['report_id, count(report_id)'],
			:group => 'report_id',
			:order => 'count(report_id) desc'
		).map do |map|
			map.report_id
		end

    Report.find :all,
      :conditions => ['id in(?) and is_public = 1 and is_trash = 0 and lang = ? ', reports_tags_ids, locale ],
      :limit => limit
    
	end

#  has_attached_file :photo,
#    :styles => {
#    :thumb => "100x100#",
#    :small  => "400x400>" },
#    :storage => :s3,
#    :s3_credentials => S3_CREDENTIALS,
#    :path => "reports/:style/:id/:filename"
  
  def self.per_page
    12
  end
  
  def self.my_per_page
    50
  end
  
  def self.per_tag_page
    8
  end
  
  def self.find_for_homepage
    find(:all,
			:conditions => ['is_trash = 0 and is_public = 1 '],
			:limit => 8,
			:order => 'created_at desc'
		)
  end
  
	def self.find_feature var = {}
    var[:lang] ||= 'en'

		find :all,
			:conditions => [ 'is_feature = 1 and is_trash = 0 and is_public = 1 and lang = ?', var[:lang] ],
			:limit => (var[:limit] || 5),
			:order => 'created_at desc'
		
	end

	def self.find_non_feature
		find(:all,
			:conditions => { :is_feature => 0, :is_trash => 0, :is_public => 1 },
			:limit => 5,
			:order => 'created_at desc'
		)
	end
  
  def self.find_in_city city_id
    find(:all,
      :conditions => { :is_trash => 0, :is_public => 1, :city_id => city_id},
      :limit => 10,
      :order => {:created_at => :asc}
    )
  end
  
  def self.find_by_venue v = Venue.new
    []
  end
  
  def self.paginate_pt args
    paginate :page => args[:page],
      :conditions => 'descr_pt is not null and name_pt is not null and is_trash = 0 and is_public = 1',
      :order => 'created_at desc',
      :limit => Report.per_page
  end
end
