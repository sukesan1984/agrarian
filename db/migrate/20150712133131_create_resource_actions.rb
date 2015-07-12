class CreateResourceActions < ActiveRecord::Migration
  def change
    create_table :resource_actions do |t|
      t.integer :action_type
      t.integer :action_id

      t.timestamps null: false
    end
  end
end
