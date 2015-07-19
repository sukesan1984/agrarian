# == Schema Information
#
# Table name: user_areas
#
#  player_id    :integer          default(0), not null, primary key
#  area_node_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserArea < ActiveRecord::Base
  belongs_to :player
  belongs_to :area_node

  INITIAL_AREA_NODE_ID = 100011
  # 現在地を取得する。レコードがなければ生成する。
  def self.get_current_or_create(player_id)
    user_area = UserArea.get_or_create(player_id)
    raise 'no area is saved' if user_area.area_node_id.nil?
    user_area.area_node_id
  end

  def self.get_or_create(player_id)
    user_area = UserArea.find_by(player_id: player_id)
    if user_area.nil?
      user_area = UserArea.create!(
        player_id: player_id,
        area_node_id: INITIAL_AREA_NODE_ID
      )
    end
    user_area
  end

  # 初期エリアに戻す。
  def give_death_penalty
    self.area_node_id = INITIAL_AREA_NODE_ID
    '始まりの街に戻された'
  end
end

