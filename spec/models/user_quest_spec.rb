# == Schema Information
#
# Table name: user_quests
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  quest_id   :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_quests_on_player_id_and_quest_id  (player_id,quest_id) UNIQUE
#

require 'rails_helper'

RSpec.describe UserQuest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
