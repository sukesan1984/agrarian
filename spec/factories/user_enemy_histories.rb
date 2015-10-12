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

FactoryGirl.define do
  factory :user_enemy_history do
    enemy_instance_id 1
player_id 1
damage 1
  end

end
