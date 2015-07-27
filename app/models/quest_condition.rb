# == Schema Information
#
# Table name: quest_conditions
#
#  id              :integer          not null, primary key
#  quest_id        :integer
#  target          :integer
#  condition_type  :integer
#  condition_id    :integer
#  condition_value :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class QuestCondition < ActiveRecord::Base
end

class ConditionType
  KillEnemy = 1
end
