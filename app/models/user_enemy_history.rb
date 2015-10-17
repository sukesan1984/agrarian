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

class UserEnemyHistory < ActiveRecord::Base
  belongs_to :enemy_instance
  def self.find_or_create(enemy_instance_id, player_id)
    user_enemy_history = UserEnemyHistory.find_by(enemy_instance_id: enemy_instance_id, player_id: player_id)
    if user_enemy_history.nil?
      user_enemy_history = UserEnemyHistory.create(
        enemy_instance_id: enemy_instance_id,
        player_id: player_id,
        damage: 0
      )
    end
    return user_enemy_history
  end
end
