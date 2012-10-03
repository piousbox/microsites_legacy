

ActiveAdmin.register Tag, :as => 'taggs' do

  scope :all, :default => true
  scope :no_parent
  scope :no_domain

  # Filterable attributes on the index screen
  #  filter :title
  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
  #  filter :price
  #  filter :created_at

  index do
    column :name
    column :name_seo
    column :domain
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
      f.input :name_seo
      f.input :subhead
      f.input :domain
      f.input :parent_tag
      # f.input :children_tags
      # f.input :children_tags, :collection => Tag.all.map {|u| [u.name, u.id]}, :include_blank => false
    end
    
#    f.has_many :children_tags do |child|
#      child.inputs 'Details' do
#        child.input :name
#      end
#    end
    
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



end
