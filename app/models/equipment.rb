# == Schema Information
#
# Table name: equipment
#
#  id                  :integer          not null, primary key
#  item_id             :integer
#  body_region         :integer
#  attack              :integer
#  defense             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  critical_hit_chance :integer          default(0), not null
#  critical_hit_damage :integer          default(0), not null
#  dodge_chance        :integer          default(0), not null
#  damage_reduction    :integer          default(0), not null
#

class Equipment < ActiveRecord::Base
end

