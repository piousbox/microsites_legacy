xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  
  @reports.each do |report|
    xml.url do
      xml.loc "http://#{request.host + report_path(report.name_seo)}"
      xml.lastmod pretty_date report.updated_at
    end
  end
  
  @galleries.each do |g|
    xml.url do
      xml.loc "http://#{request.host + gallery_path(g.galleryname, 0)}"
      xml.lastmod pretty_date g.updated_at
    end
  end
     
  @users.each do |user|
    xml.url do
      xml.loc "http://#{request.host + user_path(user.username)}"
      xml.lastmod pretty_date user.updated_at
    end
  end

  @tags.each do |tag|
    xml.url do
      xml.loc "http://#{request.host + tag_path(tag.name_seo)}"
      xml.lastmod pretty_date( tag.updated_at )
    end
  end
  
  @meta.each do |m|
    xml.url do
      xml.loc "http://#{request.host_with_port}#{m[:url]}"
      xml.lastmod pretty_date Time.now
    end
  end
  
end