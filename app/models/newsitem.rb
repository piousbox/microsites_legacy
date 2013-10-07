class Newsitem
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :user
  embedded_in :site

  belongs_to :photo
  belongs_to :report
  belongs_to :gallery
  belongs_to :video

  field :descr, :type => String
  field :username, :type => String

  field :partial_name, :type => String, :default => nil

  def self.from_params item
    n = Newsitem.new
    n.descr = item[:descr]
    n.username = item[:username]

    unless item[:report_id].blank?
      n.report = Report.find item[:report_id]
    end
    
    unless item[:gallery_id].blank?
      n.gallery = Gallery.find item[:gallery_id]
    end

    n.partial_name = item.partial_name unless item.partial_name.blank?

    return n
  end
  
end
