class AddColumnsToUserEquipments < ActiveRecord::Migration
  def change
    add_column :user_equipments, :right_hand, :integer
    add_column :user_equipments, :left_hand, :integer
    add_column :user_equipments, :both_hand, :integer
    add_column :user_equipments, :body, :integer
    add_column :user_equipments, :head, :integer
    add_column :user_equipments, :leg, :integer
    add_column :user_equipments, :neck, :integer
    add_column :user_equipments, :belt, :integer
    add_column :user_equipments, :amulet, :integer
    add_column :user_equipments, :ring_a, :integer
    add_column :user_equipments, :ring_b, :integer
  end
end
