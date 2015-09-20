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
  let(:user_item) { create(:user_item) }
  let(:user_equipment_affixes) {create_pair(:user_equipment_affix, user_item: user_item) }
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

  describe "Relation" do
    it 'has many user_equipment_affixes' do
      expect(user_item.user_equipment_affixes).to match_array user_equipment_affixes
    end
  end
end

