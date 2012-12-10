


class Video < AppModel2

  field :name, :type => String
  validates :name, :uniqueness => true, :allow_nil => false

  field :name_seo, :type => String
  validates :name_seo, :uniqueness => true, :allow_nil => false

  field :youtube_id, :type => String

  belongs_to :tag

  belongs_to :city

  belongs_to :user
  validates :user, :presence => true

end