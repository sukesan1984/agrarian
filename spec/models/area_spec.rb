# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  area_type  :integer
#  type_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  enemy_rate :integer
#

require 'rails_helper'

RSpec.describe Area, type: :model do
  it 'have_one :area_node test' do
    is_expected.to have_one(:area_node)
  end
end
