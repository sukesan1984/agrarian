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

class UserEquipmentAffix < ActiveRecord::Base
  belongs_to :equipment_affix
  belongs_to :user_item

  def name
    return self.equipment_affix.name
  end

  def prefix?
    return self.equipment_affix.prefix?
  end

  def suffix?
    return self.equipment_affix.suffix?
  end

  def status
    return @status if @status

    @status = Status.new(0, 0, 0, 0, self.str, self.dex, self.ene, self.vit, 0, 0, 0, 0, self.damage_perc, self.attack_rating_perc, self.defense_perc, self.hp, self.hp_steal_perc)

    return @status
  end
end
