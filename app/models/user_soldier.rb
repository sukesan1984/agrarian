# == Schema Information
#
# Table name: user_soldiers
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  soldier_id :integer
#  current_hp :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_soldiers_on_player_id  (player_id)
#

class UserSoldier < ActiveRecord::Base
  belongs_to :soldier
end
