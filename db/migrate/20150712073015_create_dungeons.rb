class CreateDungeons < ActiveRecord::Migration
  def change
    create_table :dungeons do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
