class Item < ActiveRecord::Base
  has_one :resource
  has_one :user_item
end
