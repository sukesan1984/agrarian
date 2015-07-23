class CreateQuestConditions < ActiveRecord::Migration
  def change
    create_table :quest_conditions do |t|
      t.integer :quest_id
      t.integer :target
      t.integer :condition_type
      t.integer :condition_id
      t.integer :condition_value

      t.timestamps null: false
    end
  end
end
