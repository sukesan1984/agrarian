class CreateUserEncounterEnemyGroups < ActiveRecord::Migration
  def change
    create_table :user_encounter_enemy_groups do |t|
      t.integer :player_id, default:0, null:false
      t.integer :enemy_group_id, default:0, null:false

      t.timestamps null: false
    end

    add_index :user_encounter_enemy_groups, :player_id, unique:true
    add_index :user_encounter_enemy_groups, :enemy_group_id
  end
end
