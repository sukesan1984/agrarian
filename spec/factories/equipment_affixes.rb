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

FactoryGirl.define do
  factory :equipment_affix do
    name "MyString"
equipment_type 1
affix_group 1
affix_type 1
rarity 1
damage_perc_min 1
damage_perc_max 1
attack_rating_perc_min 1
attack_rating_perc_max 1
defense_perc_min 1
defense_perc_max 1
hp_min 1
hp_max 1
hp_steal_perc_min ""
hp_steal_perc_max 1
  end

end
