# == Schema Information
#
# Table name: item_lotteries
#
#  id                 :integer          not null, primary key
#  group_id           :integer
#  item_id            :integer
#  count              :integer
#  weight             :integer
#  composite_group_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemLottery, type: :model do
  it 'has_composite_group_id' do
    item_lottery = ItemLottery.new(
      composite_group_id: 1
    )

    expect(item_lottery.has_composite_group_id).to eq true

    item_lottery2 = ItemLottery.new(
      composite_group_id: 0
    )

    expect(item_lottery2.has_composite_group_id).to eq false
  end
end

