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

require 'rails_helper'

RSpec.describe UserItem, type: :model do
  it 'equipped?' do
    user_item = UserItem.new(
      player_id: 1,
      item_id: 1,
      equipped: 0)

    expect(user_item.equipped?).to eq false
    user_item2 = UserItem.new(
      player_id: 1,
      item_id: 2,
      equipped: 1)
    expect(user_item2.equipped?).to eq true 

    user_item3 = UserItem.new(
      player_id: 1,
      item_id: 2,
      equipped: 10)
    expect(user_item3.equipped?).to eq true 
  end
end

