# == Schema Information
#
# Table name: user_dungeons
#
#  id             :integer          not null, primary key
#  player_id      :integer          default(0), not null
#  dungeon_id     :integer          default(0), not null
#  current_floor  :integer          default(0), not null
#  search_count   :integer          default(0), not null
#  found_footstep :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_user_dungeons_on_player_id  (player_id) UNIQUE
#

class UserDungeon < ActiveRecord::Base
end
