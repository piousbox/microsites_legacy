
class Econ::Node

  include Mongoid::Document
  include Mongoid::Timestamps

  field :x, :type => Float
  field :y, :type => Float

  field :date, :type => DateTime

  has_one :in, :class_name => 'Edge', :inverse_of => :to
  has_one :out, :class_name => 'Edge', :inverse_of => :from

  field :name, :type => String
  field :descr, :type => String
  
end
