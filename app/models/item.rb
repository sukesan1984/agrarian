class Item < ActiveRecord::Base
  has_one :resource
  has_one :user_item
  has_many :item_ability_lists
end
