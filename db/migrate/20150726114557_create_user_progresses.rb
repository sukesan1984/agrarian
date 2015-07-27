class CreateUserProgresses < ActiveRecord::Migration
  def change
    create_table :user_progresses do |t|
      t.integer :progress_type
      t.integer :progress_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
