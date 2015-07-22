# == Schema Information
#
# Table name: harvests
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_ability_id :integer
#

require 'rails_helper'

RSpec.describe Harvest, type: :model do
  it 'belongs_to :item_ability' do
    is_expected.to belong_to(:item_ability)
  end
end

