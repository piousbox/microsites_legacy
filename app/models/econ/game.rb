
class Econ::Game

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :descr, :type => String

  has_many :agents
  
end
