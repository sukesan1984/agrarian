class AddAttackToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :attack, :integer
  end
end
