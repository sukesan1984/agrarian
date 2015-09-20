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

class UserEquipmentAffix < ActiveRecord::Base
  has_one :equipment_affix
  belongs_to :user_item
end
