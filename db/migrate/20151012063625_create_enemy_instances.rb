class CreateEnemyInstances < ActiveRecord::Migration
  def change
    create_table :enemy_instances do |t|
      t.integer :enemy_group_id, default:0, null:false
      t.integer :enemy_id, default:0, null:false
      t.integer :current_hp, default:0, null:false

      t.timestamps null: false
    end

    add_index :enemy_instances, :enemy_group_id
  end
end
