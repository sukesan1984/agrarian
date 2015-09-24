# == Schema Information
#
# Table name: enemies
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  attack                :integer
#  defense               :integer
#  hp                    :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  description           :string(255)
#  rails                 :integer
#  exp                   :integer
#  item_lottery_group_id :integer          default(0), not null
#  drop_item_rate        :integer          default(0), not null
#  critical_hit_chance   :integer          default(0), not null
#  critical_hit_damage   :integer          default(0), not null
#  dodge_chance          :integer          default(0), not null
#  damage_reduction      :integer          default(0), not null
#  item_rarity           :integer
#  level                 :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Enemy, type: :model do
  it 'has_one :enemy_map test' do
    is_expected.to have_one(:enemy_map)
  end
end

