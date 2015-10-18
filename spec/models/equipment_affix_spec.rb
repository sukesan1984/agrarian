# == Schema Information
#
# Table name: equipment_affixes
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  equipment_type         :integer
#  affix_group            :integer
#  affix_type             :integer
#  rarity                 :integer
#  damage_perc_min        :integer
#  damage_perc_max        :integer
#  attack_rating_perc_min :integer
#  attack_rating_perc_max :integer
#  defense_perc_min       :integer
#  defense_perc_max       :integer
#  hp_min                 :integer
#  hp_max                 :integer
#  hp_steal_perc_min      :integer
#  hp_steal_perc_max      :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  str_min                :integer          default(0), not null
#  str_max                :integer          default(0), not null
#  dex_min                :integer          default(0), not null
#  dex_max                :integer          default(0), not null
#  vit_min                :integer          default(0), not null
#  vit_max                :integer          default(0), not null
#  ene_min                :integer          default(0), not null
#  ene_max                :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe EquipmentAffix, type: :model do
  it 'prefix?' do
    equipment_affix = build(:equipment_affix, affix_type: 1)
    expect(equipment_affix.prefix?).to eq true
    expect(equipment_affix.suffix?).to eq false 
  end

  it 'suffix?' do
    equipment_affix = build(:equipment_affix, affix_type: 2)
    expect(equipment_affix.prefix?).to eq false 
    expect(equipment_affix.suffix?).to eq true
  end
end
