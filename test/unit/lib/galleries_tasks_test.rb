#
#
#require "open-uri"
#require 'test_helper'
#require 'galleries_tasks'
#
#class TGalleriesTasksTest < ActiveSupport::TestCase
#  
#  setup do
#    url = "http://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Swanage_Punch_%26_Judy.JPG/260px-Swanage_Punch_%26_Judy.JPG"
#    @sf = FactoryGirl.create :sf
#    @city = FactoryGirl.create :city
#    
#    @g1 = SqlGallery.create :name => 'city name 1', :name_seo => 'city_name_1', :user_id => 2
#    @g2 = SqlGallery.create :name => 'city name 2', :name_seo => 'city_name_2', :user_id => 2
#    @ph1 = SqlPhoto.create :name => 'blah 1', :gallery_id => @g1.id, :photo => open(url), :user_id => 2
#    @ph2 = SqlPhoto.create :name => 'blah 2', :gallery_id => @g1.id, :photo => open(url), :user_id => 2
#    @ph3 = SqlPhoto.create :name => 'blah 3', :gallery_id => @g2.id, :photo => open(url), :user_id => 2
#    @ph4 = SqlPhoto.create :name => 'blah 4', :gallery_id => @g2.id, :photo => open(url), :user_id => 2
#    
#    @rs = []
#    [ :r5, :r6, :r7, :r8 ].each do |rr|
#      r_temp = FactoryGirl.build rr
#      if Report.where( :name_seo => r_temp.name_seo ).first.blank?
#        r_temp.save
#      end
#    end
#    
#  end
#  
#  test 'to mongoid' do
#    old_gs = SqlGallery.find( :all )
#    assert old_gs.length > 1
#    
#    old_phs = SqlPhoto.find :all
#    assert old_phs.length > 2
#    
#    Gallery.all.each { |g| g.remove }
#    Photo.all.each { |ph| ph.remove }
#    
#    #
#    # Churn!
#    #
#    GalleriesTasks.to_mongoid
#    
#    gs = Gallery.all
#    assert_equal old_gs.length, gs.length
#    phs = Photo.all
#    assert_equal old_phs.length, phs.length
#    
#    phs.each do |ph|
#      assert_equal 'piousbox', ph.user.username
#      assert_not_nil ph.photo.url(:original)
#      assert_not_nil ph.photo.url(:thumb)
#    end
#    
#  end
#  
#
#end
