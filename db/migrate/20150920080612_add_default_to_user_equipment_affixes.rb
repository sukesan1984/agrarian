class AddDefaultToUserEquipmentAffixes < ActiveRecord::Migration
  def change
    change_column_default :user_equipment_affixes, :damage_perc, 0
    change_column_default :user_equipment_affixes, :attack_rating_perc, 0
    change_column_default :user_equipment_affixes, :defense_perc, 0
    change_column_default :user_equipment_affixes, :hp, 0
    change_column_default :user_equipment_affixes, :hp_steal_perc, 0
  end
end
