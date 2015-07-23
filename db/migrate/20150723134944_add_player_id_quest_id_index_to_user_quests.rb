class AddPlayerIdQuestIdIndexToUserQuests < ActiveRecord::Migration
  def change
    add_index :user_quests, [:player_id, :quest_id], unique: true
  end
end
