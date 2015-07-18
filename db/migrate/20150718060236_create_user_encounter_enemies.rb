class CreateUserEncounterEnemies < ActiveRecord::Migration
  def change
    create_table :user_encounter_enemies do |t|
      t.integer :player_id
      t.integer :enemy_id

      t.timestamps null: false
    end
  end
end
