


class PhotoMock
  attr_accessor :photo
  attr_accessor :descr
  attr_accessor :is_public
  attr_accessor :is_trash

  def save!
    return true
  end
end

FactoryGirl.define do

  factory :photo, :class => PhotoMock do
    descr 'blah blah'
    is_public 1
    is_trash 0

    photo 'blasdf'

  end


end