

class Day
  
  include Mongoid::Document
  
  field :date, :type => String
  validates :date, :presence => true, :uniqueness => true
  
  belongs_to :user
  
  field :a1, :type => String
  field :a2, :type => String
  field :a3, :type => String
  field :a4, :type => String
  field :a5, :type => String
  
  field :work, :type => String
  field :dream, :type => String
  
end