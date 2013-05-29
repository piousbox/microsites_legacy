

class AppModel2

  include Mongoid::Document
  include Mongoid::Timestamps

  field :is_feature, :type => Boolean, :default => false
  field :is_public, :type => Boolean, :default => true
  field :is_done, :type => Boolean, :default => false
  field :is_trash, :type => Boolean, :default => false

  scope :fresh, where( :is_trash => false )
  scope :trash, where( :is_trash => true )
  scope :public, where( :is_public => true )
  scope :done, where( :is_done => true )
  
  field :x, :type => Float
  field :y, :type => Float

  def self.list conditions = { :is_trash => false }
    out = self.where( conditions).order_by( :name => :asc )
    [['', nil]] + out.map { |item| [ item.name, item.id ] }
  end

  private

  def puts! arg
    puts '+++ +++'
    puts arg.inspect
  end
  
end
