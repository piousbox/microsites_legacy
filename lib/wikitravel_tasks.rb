
require 'rubygems'
require 'simple-rss'
require 'open-uri'
require 'htmlentities'
require 'string'

class WikitravelTasks

  def self.parse_list_of_pages filename = 'wikitravel.org-popular-pages.htm'
    index_html_path = Rails.root.join( 'lib', 'data', filename )
    page = Nokogiri::HTML(open(index_html_path))
    links = page.css( "ol.special li > a" )
    links.each do |link|
      unless link['href'].include?(':')
        page = WikitravelPage.new :url => link['href'], :title => link['title']
        page.save
      end
    end
  end

  def self.random_page_to_newsitem domain = 'travel-guide.mobi'
    # create report
    r = Report.new

    # create newsitem
    n = Newsitem.new
    n.report = r
    site = Site.where( :domain => domain, :lang => :en ).first
    site.newsitems << n
    site.save

    # create newsitem for the city
    nn = Newsitem.new
    nn.report = r
    city = City.where( :name => /#{r.name}/i ).first
    unless city.blank?
      city.newsitems << nn
      city.save
    end
  end

end

def puts! args
  puts '+++ +++'
  puts args.inspect
end
