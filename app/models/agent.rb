
class Agent

  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :descr, :type => String

  belongs_to :game
  
end
