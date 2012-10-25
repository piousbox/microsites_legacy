
ActiveAdmin.register Gallery, :as => 'gallerries' do

  scope :all, :default => true
  scope :fresh
  scope :public

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
      f.input :galleryname
      f.input :is_public, :as => :boolean
    end
    
    f.inputs 'tag' do
      # f.belongs_to :tag
      f.input :tag, :as => :select, :collection => Tag.order_by(:name => :asc).map {|u| [u.name, u.id]}, :include_blank => true
    end
    
    f.inputs 'city' do
      # f.belongs_to :tag
      f.input :city, :as => :select, :collection => City.order_by(:name => :asc).map {|u| [u.name, u.id]}, :include_blank => true
    end
    
    f.inputs "Save" do
      f.submit :save
    end
    
  end

end
