# == Schema Information
#
# Table name: user_equipment_affixes
#
#  id                 :integer          not null, primary key
#  user_item_id       :integer          not null
#  equipment_affix_id :integer          not null
#  damage_perc        :integer          default(0)
#  attack_rating_perc :integer          default(0)
#  defense_perc       :integer          default(0)
#  hp                 :integer          default(0)
#  hp_steal_perc      :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  str                :integer          default(0), not null
#  dex                :integer          default(0), not null
#  vit                :integer          default(0), not null
#  ene                :integer          default(0), not null
#
# Indexes
#
#  index_user_equipment_affixes_on_user_item_id  (user_item_id)
#

FactoryGirl.define do
  factory :user_equipment_affix do
    user_item_id 0
equipment_affix_id 0
damage_perc 0
attack_rating_perc 0
defense_perc 0
hp 0
hp_steal_perc 0
  end

end
