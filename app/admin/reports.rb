

ActiveAdmin.register Report, :as => 'reportt' do

  scope :all, :default => true
  scope :not_tagged
  
  index do
    column :name
    column :tag
    default_actions
    
  end
  
  
  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :name_seo
      f.input :subhead
    end
    
    f.inputs 'Body' do
      f.text_area :descr, :input_html => { :rows => 10, :cols => 10 }
    end
    
    f.inputs 'tag' do
      # f.belongs_to :tag
      f.input :tag, :as => :select, :collection => Tag.all.map {|u| [u.name, u.id]}, :include_blank => true
    end
    
    f.inputs 'city' do
      # f.belongs_to :tag
      f.input :city, :as => :select, :collection => City.all.map {|u| [u.name, u.id]}, :include_blank => true
    end

    f.inputs "Save" do
      f.submit :save
    end
    
  end
  
end



#ActiveAdmin.register Report do
#
#  scope :all, :default => true
##  scope :is_public
##  scope :is_feature
##  scope :is_trash
#  # scope :available
#  # scope :drafts
#
#  # Filterable attributes on the index screen
#  #  filter :title
#  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
#  #  filter :price
#  #  filter :created_at
#  
#  index do
#    column :name
#    column :site
#    default_actions
#  end
#  
#  form do |f|
#    f.inputs "Details" do # physician's fields
#      f.input :name
#     
#      
#    end
#    
##    f.inputs "Reports" do
##      f.input :reports
##    end
##    
##    f.inputs "Galleries" do
##      f.input :galleries
##    end
##
##    f.has_many :reports do |report|
##      report.inputs "Report" do
##        report.input :name
##        report.input :subhead
##        report.input :descr
##      end
##      
##      report.inputs "save" do
##        report.submit :save_report
##      end
##      
##    end
##    
##    f.has_many :tags do |tag|
##      tag.inputs "Tag" do
##        tag.input :name
##        
##      end
##      
##      tag.inputs "Save" do
##        tag.submit :save_child_tag
##      end
##    end
#    
#    f.inputs "Save" do
#      f.submit :save
#    end
#  end
#  
##  form do |f|
##    f.inputs "Details" do # physician's fields
##      f.input :name
##      f.input :tag
##    end
##
##    f.inputs "Save" do
##      f.submit :save
##    end
##    
##  end
#  
#end
