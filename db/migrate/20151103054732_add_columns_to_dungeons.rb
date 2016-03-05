class AddColumnsToDungeons < ActiveRecord::Migration
  def change
    add_column :dungeons, :max_floor, :integer, default: 0, null: false
    add_column :dungeons, :min_search, :integer, default: 0, null: false
    add_column :dungeons, :max_search, :integer, default: 0 , null: false
  end
end
