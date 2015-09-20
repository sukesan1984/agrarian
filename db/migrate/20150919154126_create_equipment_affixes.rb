class CreateEquipmentAffixes < ActiveRecord::Migration
  def change
    create_table :equipment_affixes do |t|
      t.string :name
      t.integer :equipment_type
      t.integer :affix_group
      t.integer :affix_type
      t.integer :rarity
      t.integer :damage_perc_min
      t.integer :damage_perc_max
      t.integer :attack_rating_perc_min
      t.integer :attack_rating_perc_max
      t.integer :defense_perc_min
      t.integer :defense_perc_max
      t.integer :hp_min
      t.integer :hp_max
      t.integer :hp_steal_perc_min
      t.integer :hp_steal_perc_max

      t.timestamps null: false
    end
  end
end
