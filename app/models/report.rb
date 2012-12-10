


class Report < AppModel2
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
  field :subhead, :type => String
  
  field :descr, :type => String
  field :domain, :type => String, :default => ''
  scope :no_domain, where( :domain => '' )

  field :is_done, :type => Boolean, :default => true
  scope :done, where( :is_done => true )
  scope :not_done, where( :is_done => false )
  
  belongs_to :tag

  belongs_to :city

  belongs_to :user
  validates :user, :presence => true
  
  belongs_to :cities_user
  
  has_one :photo
  
  def self.list conditions = { :is_trash => 0 }
		out = self.where( conditions).order_by( :name => :asc )
		[['', nil]] + out.map { |item| [ item.name, item.id ] }
	end
  
  
  accepts_nested_attributes_for :tag, :allow_destroy => false
  
  paginates_per 12
  
  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = URI.escape d.name.sub(' ', '-').sub("\.", '')
    end
  end
  
  def self.not_tagged
    Report.where( :tag_id => nil, :city => nil )
  end
  
  def self.for_homepage args
    begin
      tag_ids = args[:main_tag].children_tags.map { |tag| tag._id } + [ args[:main_tag]._id ]
      return Report.where( :tag_id.in => tag_ids ).page args[:page]
    rescue
      return Report.page args[:page]  
    end
  end
  
end