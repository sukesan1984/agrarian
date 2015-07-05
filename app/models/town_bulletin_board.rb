class TownBulletinBoard < ActiveRecord::Base
  belongs_to :town
  belongs_to :player
end
