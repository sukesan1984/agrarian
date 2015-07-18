class AddPlayerIdIndexToUserEncounterEnemy < ActiveRecord::Migration
  def change
    add_index :user_encounter_enemies, :player_id
  end
end
