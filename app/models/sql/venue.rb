
class Venue < ActiveRecord::Base

	extend AppModel

	belongs_to :venue_type
	belongs_to :city
	belongs_to :cities_user
  
  validates :name, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
  validates :name_seo, :length => { :minimum => 2 }, :presence => true, :uniqueness => true
  
  has_attached_file :photo,
    :styles => {
    :thumb=> "100x100#",
    :mini => '20x20#',
    :small  => "400x400>",
    :medium => '600x800>'
  },
    :storage => :s3,
    :s3_credentials => S3_CREDENTIALS,
    :path => "venues/:style/:id/:filename"
  
  def self.find_in_city city_id
    find(:all, 
      :conditions => { :is_trash => 0, :city_id => city_id, :is_public => 1},
      :limit => 10
    )
  end
  
  def self.weekly_in city_id, venue_type_id = nil
    conditions = { :city_id => city_id, :is_public => 1, :is_trash => 0 }
    unless venue_type_id.blank?
      conditions.merge!({:venue_type_id => venue_type_id})
    end
    
    su = Venue.find(:all,
      :conditions => conditions.merge(:su => true),
      :order => 'name asc'
    )
    
    mo = Venue.find(:all,
      :conditions => conditions.merge(:mo => true),
      :order => 'name asc'
    )
    
    tu = Venue.find(:all,
      :conditions => conditions.merge(:tu => true),
      :order => 'name asc'
    )
    
    we = Venue.find(:all,
      :conditions => conditions.merge(:we => true),
      :order => 'name asc'
    )
    
    th = Venue.find(:all,
      :conditions => conditions.merge(:th => true),
      :order => 'name asc'
    )
    
    fr = Venue.find(:all,
      :conditions => conditions.merge(:fr => true),
      :order => 'name asc'
    )
    
    sa = Venue.find(:all,
      :conditions => conditions.merge(:sa => true),
      :order => 'name asc'
    )
    
    out = ActiveSupport::OrderedHash.new
    out['su'] = su
    out['mo'] = mo
    out['tu'] = tu
    out['we'] = we
    out['th'] = th
    out['fr'] = fr
    out['sa'] = sa

    return out    
  end
	
end
