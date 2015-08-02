class AddColumnsToUserSoldiers < ActiveRecord::Migration
  def change
    add_column :user_soldiers, :right_hand, :integer, default: 0
    add_column :user_soldiers, :left_hand,  :integer, default: 0
    add_column :user_soldiers, :both_hand,  :integer, default: 0 
    add_column :user_soldiers, :body,       :integer, default: 0 
    add_column :user_soldiers, :head,       :integer, default: 0 
    add_column :user_soldiers, :leg,        :integer, default: 0 
    add_column :user_soldiers, :neck,       :integer, default: 0 
    add_column :user_soldiers, :belt,       :integer, default: 0 
    add_column :user_soldiers, :amulet,     :integer, default: 0 
    add_column :user_soldiers, :ring_a,     :integer, default: 0 
    add_column :user_soldiers, :ring_b,     :integer, default: 0 
  end
end
