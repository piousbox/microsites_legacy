
ActiveAdmin.register Report do

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
    #    column "Price", :sortable => :price do |product|
    #      number_to_currency product.price
    #    end
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :tag
    end

   
    
  end
  
end
