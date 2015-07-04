class CreateUserAreas < ActiveRecord::Migration
  def change
    create_table :user_areas, :id => false do |t|
      t.integer :player_id
      t.integer :area_id

      t.timestamps null: false
    end
    execute "ALTER TABLE user_areas ADD PRIMARY KEY (player_id);"
  end
end
