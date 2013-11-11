xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  
  @galleries.each do |g|
    xml.url do
      xml.loc "http://#{ request.host + gallery_show_style_path('show_mini', g.galleryname,) }"
      xml.lastmod pretty_date g.updated_at
    end
    xml.url do
      xml.loc "http://#{ request.host + gallery_show_style_path('show_long', g.galleryname,) }"
      xml.lastmod pretty_date g.updated_at
    end
    
    g.photos.each_with_index do |photo, idx|
      xml.url do
        xml.loc "http://#{ request.host + gallery_path(g.galleryname, idx) }"
        xml.lastmod pretty_date g.updated_at
      end
    end
 
  end
  
end