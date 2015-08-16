class RenameNumColumnToRecipes < ActiveRecord::Migration
  def change
    rename_column :recipes, :required_item_num1, :required_item_count1
    rename_column :recipes, :required_item_num2, :required_item_count2
    rename_column :recipes, :required_item_num3, :required_item_count3
    rename_column :recipes, :required_item_num4, :required_item_count4
    rename_column :recipes, :required_item_num5, :required_item_count5
    rename_column :recipes, :product_item_num, :product_item_count
  end
end
