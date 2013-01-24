
class Econ::Edge

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :to, :class_name => 'Node', :inverse_of => :in
  belongs_to :from, :class_name => 'Node', :inverse_of => :out

  field :name, :type => String
  field :descr, :type => String
  
end
