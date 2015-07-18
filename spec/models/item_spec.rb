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
