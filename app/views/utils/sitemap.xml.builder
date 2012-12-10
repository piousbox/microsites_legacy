
xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'

xml.urlset :xmlns => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  
  @reports.each do |report|
    xml.url do
      xml.loc "http://#{request.host + report_path(report)}"
      xml.lastmod pretty_date report.updated_at
    end
  end
  
  @galleries.each do |g|
    xml.url do
      xml.loc "http://#{request.host + gallery_path(g)}"
      xml.lastmod pretty_date g.updated_at
    end
  end
  
  @cities.each do |c|
    xml.url do
      xml.loc "http://#{request.host + city_path(c)}"
      xml.lastmod pretty_date c.updated_at
    end
  end
  
  @tags.each do |c|
    xml.url do
      xml.loc "http://#{request.host + tag_path(c)}"
      xml.lastmod pretty_date c.updated_at
    end
  end
  
  @countries.each do |c|
    xml.url do
      xml.loc "http://#{request.host + country_path(c)}"
      xml.lastmod pretty_date c.updated_at
    end
  end
 
  @users.each do |c|
    xml.url do
      xml.loc "http://#{request.host + user_path(c)}"
      xml.lastmod pretty_date c.updated_at
    end
  end
  
  @venues.each do |c|
    xml.url do
      xml.loc "http://#{request.host + venue_path(c)}"
      xml.lastmod pretty_date c.updated_at
    end
  end
  
end