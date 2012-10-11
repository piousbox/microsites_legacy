class Addressbookitem < ActiveRecord::Base

	extend AppModel

  belongs_to :user
	belongs_to :city
	belongs_to :venue
	belongs_to :event
	belongs_to :cities_user

	has_many :addressbookitems_tag, :dependent => :destroy
	has_many :tag, :through => :addressbookitems_tag
  
  validates_uniqueness_of :name, :scope => [:user_id]

  def self.find_mine_timelined(user_id)
    find(:all,
      :conditions => ['user_id = ? and is_trash = 0 and cities_user_id > 0', user_id],
      :order => 'name asc'
    )
  end
  
  def self.find_mine(user_id)
    find(:all,
      :conditions => ['user_id = ? and is_trash = 0', user_id],
      :order => 'name asc'
    )
  end
  
end
