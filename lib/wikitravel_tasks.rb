require 'rubygems'
require 'open-uri'
require 'htmlentities'
require 'string'

class WikitravelTasks

  def self.random_page_to_newsitem domain = 'travel-guide.mobi'
    site = Site.where( :domain => domain, :lang => :en ).first
    anon = User.where( :username => 'anon' ).first    

    # select a random page
    begin
      n_pages = WikitravelPage.all.length
      random_page = WikitravelPage.all[rand(n_pages-1)]
      existing_report = Report.where( :name => random_page.title ).first
    end while !existing_report.blank?
    
    remote_page = Nokogiri::HTML(open("#{WikitravelPage::DOMAIN}#{random_page.url}"))
    text = remote_page.css("#mw-content-text tr > td").text
    subhead = remote_page.css("#mw-content-text tr > td p")[0].text
    
    # create the report
    r = Report.new
    r.name = random_page.title
    r.name_seo = random_page.url
    r.subhead = subhead
    r.descr = text
    r.site = site
    r.user = anon
    r.save || puts!(r.errors)
    
    # create newsitem for the site
    n = Newsitem.new
    n.report = r
    site.newsitems << n
    site.save || puts!(site.errors)

    # create newsitem for the city
    nn = Newsitem.new
    nn.report = r
    city = City.where( :name => /#{r.name}/i ).first
    unless city.blank?
      city.newsitems << nn
      city.save
    end
  end

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

end

def puts! args
  puts '+++ +++'
  puts args.inspect
end
