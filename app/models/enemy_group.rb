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

class EnemyGroup < ActiveRecord::Base
  module Status
    Alive = 0
    Death = 1
  end
end
