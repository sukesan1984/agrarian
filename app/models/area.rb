class Area < ActiveRecord::Base
  has_one :user_area
  has_one :area_node
end
