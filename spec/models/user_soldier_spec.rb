# == Schema Information
#
# Table name: user_soldiers
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  soldier_id :integer
#  current_hp :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_soldiers_on_player_id  (player_id)
#

require 'rails_helper'

RSpec.describe UserSoldier, type: :model do
  it { is_expected.to belong_to(:soldier) }
end
