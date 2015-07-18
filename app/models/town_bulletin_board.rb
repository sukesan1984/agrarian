# == Schema Information
#
# Table name: town_bulletin_boards
#
#  id         :integer          not null, primary key
#  town_id    :integer
#  player_id  :integer
#  contents   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_town_bulletin_boards_on_town_id  (town_id)
#

class TownBulletinBoard < ActiveRecord::Base
  belongs_to :town
  belongs_to :player
end
