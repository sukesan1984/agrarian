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
  def setup_to_dungeon_entrance(dungeon_id)
    self.dungeon_id = dungeon_id
    self.current_floor = 1
    self.search_count = 0
    self.found_footstep = false
  end

  def self.find_or_new(player_id, dungeon_id)
    user_dungeon = UserDungeon.find_by(player_id: player_id, dungeon_id: dungeon_id)
    if user_dungeon.nil?
      user_dungeon = UserDungeon.new(
        player_id: player_id,
        dungeon_id: 0,
        current_floor: 1,
        search_count: 0,
        found_footstep: false
      )
    end
    return user_dungeon
  end
end
