
FactoryGirl.define do

  # sequenced
  factory :addressbookitem, :class => Addressbookitem do
    sequence( :name ) do |n|
      "Addritem #{n}"
    end
    after :build do |t|
      t.user = User.all.first || User.new
    end
  end

end
