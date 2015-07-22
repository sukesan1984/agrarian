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

require 'rails_helper'

RSpec.describe UserEquipment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

