class RenameTypeColumnToAreas < ActiveRecord::Migration
  def change
    rename_column :areas, :type, :area_type
  end
end
