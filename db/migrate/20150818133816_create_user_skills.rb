class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :player_id
      t.integer :skill_id
      t.integer :skill_point

      t.timestamps null: false
    end
  end
end
