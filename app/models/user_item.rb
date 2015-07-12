class UserItem < ActiveRecord::Base

  def self.find_or_create(player_id, item_id)
    user_item = UserItem.find_by(player_id: player_id, item_id: item_id)
    if(user_item.nil?)
      user_item = UserItem.create(
        player_id: player_id,
        item_id: item_id,
        count: 0
      )
    end
    logger.debug(user_item)
    return user_item
  end
end
