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

require 'rails_helper'

RSpec.describe UserEncounterEnemy, type: :model do
  it { is_expected.to belong_to(:enemy) }
end
