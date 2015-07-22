# == Schema Information
#
# Table name: enemy_maps
#
#  id         :integer          not null, primary key
#  area_id    :integer
#  enemy_id   :integer
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_enemy_maps_on_area_id  (area_id)
#

require 'rails_helper'

RSpec.describe EnemyMap, type: :model do
  it 'belongs_to :enemy test' do
    is_expected.to belong_to(:enemy)
  end
end

