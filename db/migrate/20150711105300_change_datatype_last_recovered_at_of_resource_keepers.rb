class ChangeDatatypeLastRecoveredAtOfResourceKeepers < ActiveRecord::Migration
  def change
    change_column :resource_keepers, :last_recovered_at, :datetime
  end
end
