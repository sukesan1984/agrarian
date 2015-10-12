# == Schema Information
#
# Table name: enemy_instances
#
#  id             :integer          not null, primary key
#  enemy_group_id :integer          default(0), not null
#  enemy_id       :integer          default(0), not null
#  current_hp     :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_enemy_instances_on_enemy_group_id  (enemy_group_id)
#

class EnemyInstance < ActiveRecord::Base
end
