class CreateUserEnemyHistories < ActiveRecord::Migration
  def change
    create_table :user_enemy_histories do |t|
      t.integer :enemy_instance_id, default:0, null:false
      t.integer :player_id, default: 0, null:false
      t.integer :damage, default: 0, null:false

      t.timestamps null: false
    end

    add_index :user_enemy_histories, :enemy_instance_id
    add_index :user_enemy_histories, [:enemy_instance_id, :player_id], unique: true
  end
end
