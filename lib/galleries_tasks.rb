
require 'cgi'

class GalleriesTasks
  
  
  def self.clean_name_seo
    galleries = Gallery.find :all
    galleries.each do |g|
      Util.clean_name_seo g
    end
  end
  
  def self.to_mongoid
    # take all photos
    old_photos = SqlPhoto.find :all
    old_photos.each do |old_photo|
      # create new photo
      new_photo = Photo.new
      new_photo.photo = open(old_photo.photo.url(:original))
      
      # gallery?
      unless old_photo.gallery_id.blank?
        begin
          old_gallery = SqlGallery.find old_photo.gallery_id
          new_gallery = Gallery.where( :galleryname => old_gallery.name_seo ).first
          if new_gallery.blank?
            # create new gallery
            new_gallery = Gallery.new
            new_gallery.name = old_gallery.name
            ###
            ###
            ###
            
            new_gallery.save
            
          else
            # new gallery already exists
          end
        rescue
          # probably gallery is deleted
        end
      end
      
      new_photo.gallery = new_gallery
      new_photo.save
      
    end
  end
  
end