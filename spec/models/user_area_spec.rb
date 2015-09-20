# == Schema Information
#
# Table name: user_areas
#
#  player_id    :integer          default(0), not null, primary key
#  area_node_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe UserArea, type: :model do
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:area_node) }
end

