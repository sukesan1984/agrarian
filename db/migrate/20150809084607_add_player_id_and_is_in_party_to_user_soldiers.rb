class AddPlayerIdAndIsInPartyToUserSoldiers < ActiveRecord::Migration
  def change
    add_index :user_soldiers, [:player_id, :is_in_party]
  end
end
