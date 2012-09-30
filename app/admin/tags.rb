

ActiveAdmin.register Tag do

  scope :all, :default => true
  # scope :available
  # scope :drafts

  # Filterable attributes on the index screen
  #  filter :title
  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
  #  filter :price
  #  filter :created_at

  index do
    column :name
    column :site
    default_actions
  end
  
  show do |tag|
    attributes_table do
      row :name
      row :subhead
    end
    
    table_for(tag.reports) do |t|
      t.column :name
    end
    
  end

  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :subhead
      f.input :domain
      f.input :site
      
    end
    
#    f.inputs "Reports" do
#      f.input :reports
#    end
#    
#    f.inputs "Galleries" do
#      f.input :galleries
#    end
#
#    f.has_many :reports do |report|
#      report.inputs "Report" do
#        report.input :name
#        report.input :subhead
#        report.input :descr
#      end
#      
#      report.inputs "save" do
#        report.submit :save_report
#      end
#      
#    end
#    
#    f.has_many :tags do |tag|
#      tag.inputs "Tag" do
#        tag.input :name
#        
#      end
#      
#      tag.inputs "Save" do
#        tag.submit :save_child_tag
#      end
#    end
    
    f.inputs "Save" do
      f.submit :save
    end
  end

end
