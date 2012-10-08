


class Report
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false
  
  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false
  
  field :subhead, :type => String
  
  field :descr, :type => String
  
  field :is_public, :type => Boolean, :default => true
  field :is_feature, :type => Boolean, :default => false
  field :is_trash, :type => Boolean, :default => false
  
  field :lang, :type => String
  
  belongs_to :tag
  accepts_nested_attributes_for :tag, :allow_destroy => false
  
  before_create do |d|
    if d.name_seo.blank?
      d.name_seo = URI.escape d.name.sub(' ', '-').sub("\.", '')
    end
  end
  
  def self.not_tagged
    Report.where( :tag_id => nil )
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