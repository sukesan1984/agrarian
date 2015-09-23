class AddEnemyNumAreas < ActiveRecord::Migration
  def change
    add_column :areas, :enemy_num, :integer
  end
end
