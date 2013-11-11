
require 'spec_helper'
require 'galleries_tasks'

describe GalleriesTasks do

  describe '#to_photo_names' do
    before :each do
      Gallery.unscoped.each { |g| g.remove }
      @g = FactoryGirl.create :gallery

      Photo.unscoped.each { |p| p.remove }
      @ph1 = FactoryGirl.create :photo_without_name
    end

    it 'does' do
      # first, does not affect photos outside galleries
      GalleriesTasks.to_photo_names
      @ph1.name.should eql ''
      
      @ph1.gallery = @g
      @ph1.save

      # next, transfers the gallery name
      GalleriesTasks.to_photo_names
      @ph1 = Photo.find @ph1.id
      @ph1.name.should eql @g.name

      # next, does not affext photos with existing names
      @g.descr = 'some descr'
      @g.save
      GalleriesTasks.to_photo_names
      @ph1 = Photo.find @ph1.id
      @ph1.name.should eql @g.name

      # next, transfers the gallery descr
      @ph1.name = ''
      @ph1.save
      GalleriesTasks.to_photo_names
      @ph1 = Photo.find @ph1.id
      @ph1.name.should eql @g.descr
      
    end
  end

end

