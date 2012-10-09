

module Valid
  
  extend ActiveSupport::Concern

  included do
    validates :name, :length => { :minimum => 1 }, :presence => true
    validates :name_seo, :length => { :minimum => 1 }, :presence => true, :uniqueness => true
  end
  
end