
ActiveAdmin.register Site do

  # Create sections on the index screen
  scope :all, :default => true
  # scope :available
  # scope :drafts

  # Filterable attributes on the index screen
  #  filter :title
  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
  #  filter :price
  #  filter :created_at

  # Customize columns displayed on the index screen in the table
  index do
    column :name
    column :domain
    
    #    column "Price", :sortable => :price do |product|
    #      number_to_currency product.price
    #    end
    default_actions
  end
  
#  show do |tag|
#    attributes_table do
#      row :name
#      row :subhead
#    end
#    
#    table_for(tag.reports) do |t|
#      t.column :name
#      t.column :subhead
#      
#    end
#    
#  end

  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :subhead
      f.input :domain
    end
    
    f.inputs "Save" do
      f.submit :save
    end
  end

end
