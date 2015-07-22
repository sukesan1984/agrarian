# == Schema Information
#
# Table name: user_encounter_enemies
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  enemy_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_encounter_enemies_on_player_id  (player_id)
#

FactoryGirl.define do
  factory :user_encounter_enemy do
    
  end

end
