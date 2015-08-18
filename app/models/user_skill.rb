# == Schema Information
#
# Table name: user_skills
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  skill_id    :integer
#  skill_point :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserSkill < ActiveRecord::Base
  belongs_to :skill

  def self.find_or_create(player_id, skill_ids)
    # 一回有効性チェックしておく
    skills = Skill.where('id in (?)', skill_ids)
    valid_skill_ids = skills.map(&:id)

    user_skills = UserSkill.where('player_id = ? and skill_id in (?)', player_id, skill_ids)
    valid_skill_ids.each do |skill_id|
      unless user_skills.map(&:skill_id).include?(skill_id)
        user_skill = UserSkill.create(
          player_id: player_id,
          skill_id: skill_id,
          skill_point: 0
        )
        user_skills.push(user_skill)
      end
    end
    return user_skills
  end
end
