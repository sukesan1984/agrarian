class AddEnemyRateToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :enemy_rate, :integer
  end
end
