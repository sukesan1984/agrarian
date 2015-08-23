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

  # 実際の値は、skill_pointを10で割った値で表示する。
  FOR_DISPLAY_RATE = 10.0
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

  def increase(value)
    self.skill_point += value
  end

  def real_skill_point
    return (self.skill_point / FOR_DISPLAY_RATE).to_f
  end

  # 上昇を試みる
  # 失敗するかも
  def try_increase(difficulty)
    rate = UserSkill.calculate_increase_rate(real_skill_point, difficulty)
    seed = rand(0.0...100.0)
    Rails.logger.debug("スキル上昇率#{rate}:#{seed}")
    if rate > seed
      increase(1)
      return (1 / FOR_DISPLAY_RATE).to_f
    end
    return 0
  end

  # difficultyとskill_pointの関係からスキルの上がる確率を計算する.
  def self.calculate_increase_rate(real_skill_point, difficulty)
    Rails.logger.debug("スキル:#{real_skill_point} 難易度:#{difficulty}")
    rate = 100 * 2**(-(real_skill_point - difficulty + 20) / 10) * (300 - real_skill_point) / 300
    return 100 if rate > 100
    return rate
  end
end

