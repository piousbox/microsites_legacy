

ActiveAdmin.register City, :as => 'citties' do

  scope :all, :default => true
  scope :feature
  scope :non_feature

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
      row :community
      row :calendar_frame
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
    end
    
    f.inputs "Communitiess" do
      f.text_area :community, :input_html => { :rows => 10, :cols => 10 }
    end
    
    f.inputs "calendar" do
      f.text_area :calendar_frame, :input_html => { :rows => 10, :cols => 10 }
    end
    
    f.inputs "Save" do
      f.submit :save
    end
    
  end
  

end
