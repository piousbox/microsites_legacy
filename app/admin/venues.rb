

ActiveAdmin.register Venue, :as => 'venues' do

  scope :all, :default => true

  index do
    column :name
    default_actions

  end

  form do |f|
    f.inputs "Details" do # physician's fields
      f.input :name
      f.input :name_seo
      f.input :descr
      f.input :x
      f.input :y
    end

    f.inputs 'user' do
      # f.belongs_to :tag
      f.input :user, :as => :select, :collection => User.all.map {|u| [u.username, u.id]}, :include_blank => false
      f.input :city, :as => :select, :collection => City.all.map {|u| [u.name, u.id]}, :include_blank => true
    end

    f.inputs "Save" do
      f.submit :save
    end

  end

end

