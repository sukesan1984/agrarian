class RenameStrColumnToSoldiers < ActiveRecord::Migration
  def change
    rename_column :soldiers, :attack_min, :str_min
    rename_column :soldiers, :attack_max, :str_max
    rename_column :soldiers, :defense_min, :dex_min
    rename_column :soldiers, :defense_max, :dex_max
    rename_column :soldiers, :hp_min, :vit_min
    rename_column :soldiers, :hp_max, :vit_max
    add_column :soldiers, :ene_min, :integer, default: 0, null:false
    add_column :soldiers, :ene_max, :integer, default: 0, null:false
  end
end
