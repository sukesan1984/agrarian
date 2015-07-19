# == Schema Information
#
# Table name: user_equipments
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  right_hand :integer
#  left_hand  :integer
#  both_hand  :integer
#  body       :integer
#  head       :integer
#  leg        :integer
#  neck       :integer
#  belt       :integer
#  amulet     :integer
#  ring_a     :integer
#  ring_b     :integer
#
# Indexes
#
#  index_user_equipments_on_player_id_and_body_region  (player_id)
#

class UserEquipment < ActiveRecord::Base
  def self.get_or_create(player_id)
    user_equipment = UserEquipment.find_by(player_id: player_id)
    if user_equipment.nil?
      user_equipment = UserEquipment.create(
        player_id: player_id
      )
    end
    return user_equipment
  end
end
