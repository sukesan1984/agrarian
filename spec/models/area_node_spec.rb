# == Schema Information
#
# Table name: area_nodes
#
#  id         :integer          not null, primary key
#  area_id    :integer
#  node_point :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_area_nodes_on_area_id  (area_id)
#

require 'rails_helper'

RSpec.describe AreaNode, type: :model do
  it 'belong_to :area test' do
    is_expected.to belong_to(:area)
  end
  it 'has_one :user_area test' do
    is_expected.to have_one(:user_area)
  end
end

