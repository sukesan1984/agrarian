# == Schema Information
#
# Table name: thrown_items
#
#  id           :integer          not null, primary key
#  area_node_id :integer
#  item_id      :integer
#  count        :integer
#  thrown_at    :datetime         default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default(0), not null
#  user_item_id :integer          default(0), not null
#
# Indexes
#
#  index_thrown_items_on_area_node_id_and_item_id_and_user_item_id  (area_node_id,item_id,user_item_id) UNIQUE
#

class ThrownItem < ActiveRecord::Base
  belongs_to :item
  # 捨てられてから有効な時間
  THROWN_VALID_SECONDS = 30 * 24 * 60 * 60

  def is_valid
    return false if count == 0
    # 捨てられてからの経過時間が有効期限以下であれば有効
    return (Time.now - thrown_at) <= THROWN_VALID_SECONDS
  end

  def decrease(value)
    after_count = count - value
    return false if after_count < 0

    self.count = after_count
    return true
  end

  def self.get_or_new_by_area_node_id_and_item_id(area_node_id, item_id)
    thrown_item = find_by(area_node_id: area_node_id, item_id: item_id)

    if thrown_item.nil?
      thrown_item = ThrownItem.new(
        area_node_id: area_node_id,
        item_id: item_id,
        count: 0,
        thrown_at: Time.now
      )
    end

    return thrown_item
  end

  # user_item_id指定バージョン
  def self.get_or_new_by_area_node_id_and_item_id_and_user_item_id(area_node_id, item_id, user_item_id)
    thrown_item = find_by(area_node_id: area_node_id, item_id: item_id, user_item_id: user_item_id)

    if thrown_item.nil?
      thrown_item = ThrownItem.new(
        area_node_id: area_node_id,
        item_id: item_id,
        user_item_id: user_item_id,
        count: 0,
        thrown_at: Time.now
      )
    end

    return thrown_item
  end
end

