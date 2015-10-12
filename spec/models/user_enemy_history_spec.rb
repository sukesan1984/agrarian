# == Schema Information
#
# Table name: user_enemy_histories
#
#  id                :integer          not null, primary key
#  enemy_instance_id :integer          default(0), not null
#  player_id         :integer          default(0), not null
#  damage            :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_user_enemy_histories_on_enemy_instance_id                (enemy_instance_id)
#  index_user_enemy_histories_on_enemy_instance_id_and_player_id  (enemy_instance_id,player_id) UNIQUE
#

require 'rails_helper'

RSpec.describe UserEnemyHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
