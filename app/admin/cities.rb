

ActiveAdmin.register City, :as => 'cities' do

  scope :all, :default => true
  scope :feature
  scope :non_feature
#  scope :no_domain

  # Filterable attributes on the index screen
  #  filter :title
  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
  #  filter :price
  #  filter :created_at

  index do
    column :name
    column :cityname
    default_actions
  end
  
  show do |city|
    attributes_table do
      row :name
    end
    
    table_for(city.reports) do |t|
      t.column :name
    end
    
  end

  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :cityname
      f.input :is_feature, :as => :boolean
      f.input :x
      f.input :y
      
      f.input :calendar_frame

    end
    
    f.inputs "Save" do
      f.submit :save
    end
  end
  

end
