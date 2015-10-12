# == Schema Information
#
# Table name: enemy_groups
#
#  id           :integer          not null, primary key
#  area_node_id :integer          default(0), not null
#  status       :integer          default(0), not null
#  player_num   :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_enemy_groups_on_area_node_id_and_status_and_player_num  (area_node_id,status,player_num)
#

require 'rails_helper'

RSpec.describe EnemyGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
