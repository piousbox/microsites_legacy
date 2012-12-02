

ActiveAdmin.register Site, :as => 'sitees' do

  scope :all, :default => true
#  scope :no_domain

  # Filterable attributes on the index screen
  #  filter :title
  #  filter :author, :as => :select, :collection => lambda{ Product.authors }
  #  filter :price
  #  filter :created_at

  index do
    column :domain
    column :title
    column :subhead
    default_actions
  end

  show do |p|
    attributes_table do
      row :domain
      row :title
      row :subhead
    end

  end

  form do |f|

    f.inputs "Details" do # physician's fields
      f.input :domain
      f.input :title
      f.input :subhead
    end

    f.inputs "Save" do
      f.submit :save
    end

  end


end
