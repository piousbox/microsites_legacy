
class Newsitem

  include Mongoid::Document
  include Mongoid::Timestamps
  
  embedded_in :city
  embedded_in :user
  embedded_in :venue
  embedded_in :site

  belongs_to :photo
  belongs_to :report
  belongs_to :gallery

  field :descr, :type => String
  field :username, :type => String

  field :lang, :type => String, :default => 'en'

  def self.from_params item
    n = Newsitem.new item
    n.descr = item[:descr]
    n.username = item[:username]

    unless item[:report_id].blank?
      n.report = Report.find item[:report_id]
    end
    
    unless item[:gallery_id].blank?
      n.gallery = Gallery.find item[:gallery_id]
    end

    return n
  end
  
end
