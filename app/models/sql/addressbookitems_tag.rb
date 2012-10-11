class AddressbookitemsTag < ActiveRecord::Base

	has_many :addressbookitem
	has_many :tag
	
end
