# == Schema Information
#
# Table name: items
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  item_type      :integer
#  item_type_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  purchase_price :integer
#  sell_price     :integer
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'has_one :resource test' do
    is_expected.to have_one(:resource)
  end
  it 'has_one :user_item test' do
    is_expected.to have_one(:user_item)
  end
  it 'has_many :item_ability_lists test' do
    is_expected.to have_many(:item_ability_lists)
  end
end

