require 'rails_helper'

RSpec.describe ItemAbility, type: :model do
  it 'has_many :item_ability_lists test' do
    is_expected.to have_many(:item_ability_lists)
  end
  it 'has_one :harvest test' do
    is_expected.to have_one(:harvest)
  end
end
