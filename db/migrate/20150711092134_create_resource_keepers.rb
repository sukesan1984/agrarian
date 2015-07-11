class CreateResourceKeepers < ActiveRecord::Migration
  def change
    create_table :resource_keepers do |t|
      t.integer :target_id
      t.integer :current_count
      t.integer :last_recovered_at

      t.timestamps null: false
    end
  end
end
