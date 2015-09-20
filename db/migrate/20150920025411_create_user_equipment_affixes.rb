class CreateUserEquipmentAffixes < ActiveRecord::Migration
  def change
    create_table :user_equipment_affixes do |t|
      t.integer :user_item_id
      t.integer :equipment_affix_id
      t.integer :damage_perc
      t.integer :attack_rating_perc
      t.integer :defense_perc
      t.integer :hp
      t.integer :hp_steal_perc

      t.timestamps null: false
    end
  end
end
