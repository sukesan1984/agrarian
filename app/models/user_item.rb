# == Schema Information
#
# Table name: user_items
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipped   :integer          default(0)
#
# Indexes
#
#  index_user_items_on_player_id_and_item_id  (player_id,item_id)
#

class UserItem < ActiveRecord::Base
  belongs_to :item
  has_many :user_equipment_affixes, :dependent => :delete_all

  def increase(value)
    after_count = count + value
    return false if after_count < 0

    self.count = after_count
    return true
  end

  def self.find_or_create(player_id, item_id)
    user_item = UserItem.find_by(player_id: player_id, item_id: item_id)
    if user_item.nil?
      user_item = UserItem.create(
        player_id: player_id,
        item_id: item_id,
        count: 0
      )
    end
    logger.debug(user_item)
    user_item
  end

  def equipped?
    return equipped != 0
  end
end

