class DictionaryitemsTag < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :dictionaryitem
end
