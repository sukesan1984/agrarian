# == Schema Information
#
# Table name: user_encounter_enemy_groups
#
#  id             :integer          not null, primary key
#  player_id      :integer          default(0), not null
#  enemy_group_id :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_user_encounter_enemy_groups_on_enemy_group_id  (enemy_group_id)
#  index_user_encounter_enemy_groups_on_player_id       (player_id) UNIQUE
#

require 'rails_helper'

RSpec.describe UserEncounterEnemyGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
