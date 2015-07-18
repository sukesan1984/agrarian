require 'rails_helper'

RSpec.describe ItemAbilityList, type: :model do
  it { is_expected.to belong_to(:item_ability) }
  it { is_expected.to belong_to(:item) }
end
