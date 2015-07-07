class AreaNode < ActiveRecord::Base
  belongs_to :area
  has_one :user_area
end
