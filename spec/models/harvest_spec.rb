require 'rails_helper'

RSpec.describe Harvest, type: :model do
  it 'belongs_to :item_ability' do
    is_expected.to belong_to(:item_ability)
  end
end
