# == Schema Information
#
# Table name: item_ability_lists
#
#  id              :integer          not null, primary key
#  item_id         :integer
#  item_ability_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemAbilityList, type: :model do
  it { is_expected.to belong_to(:item_ability) }
  it { is_expected.to belong_to(:item) }
end
