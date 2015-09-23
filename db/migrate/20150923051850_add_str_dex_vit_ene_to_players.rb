class AddStrDexVitEneToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :str, :integer, default:2, null:false
    add_column :players, :dex, :integer, default:5, null:false
    add_column :players, :vit, :integer, default:3, null:false
    add_column :players, :ene, :integer, default:5, null:false
  end
end
