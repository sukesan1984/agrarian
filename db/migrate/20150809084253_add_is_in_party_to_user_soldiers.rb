class AddIsInPartyToUserSoldiers < ActiveRecord::Migration
  def change
    add_column :user_soldiers, :is_in_party, :integer
  end
end
