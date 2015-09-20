# == Schema Information
#
# Table name: user_equipment_affixes
#
#  id                 :integer          not null, primary key
#  user_item_id       :integer
#  equipment_affix_id :integer
#  damage_perc        :integer
#  attack_rating_perc :integer
#  defense_perc       :integer
#  hp                 :integer
#  hp_steal_perc      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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
