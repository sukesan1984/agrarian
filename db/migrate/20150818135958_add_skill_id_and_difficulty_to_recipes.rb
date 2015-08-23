class AddSkillIdAndDifficultyToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :skill_id, :integer
    add_column :recipes, :difficulty, :integer
  end
end
