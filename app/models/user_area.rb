class UserArea < ActiveRecord::Base
  belongs_to :player
  belongs_to :area

  INITIAL_AREA_NODE_ID = 100011
  # 現在地を取得する。レコードがなければ生成する。
  def UserArea.get_current_or_create(player_id)
    user_area = UserArea.get_or_create(player_id)
    if(user_area.area_node_id == nil)
      raise "no area is saved"
    end
    return user_area.area_node_id
  end

  def UserArea.get_or_create(player_id)
    user_area = UserArea.find_by(player_id: player_id)
    if(user_area == nil)
      user_area = UserArea.create!(
        player_id: player_id,
        area_node_id: INITIAL_AREA_NODE_ID
      )
    end
    return user_area
  end
end
