class CreateEnemyGroups < ActiveRecord::Migration
  def change
    create_table :enemy_groups do |t|
      t.integer :area_node_id, default:0, null:false
      t.integer :status, default: 0, null:false
      t.integer :player_num, default: 0, null:false

      t.timestamps null: false
    end

    add_index :enemy_groups, [:area_node_id, :status, :player_num]
  end
end
