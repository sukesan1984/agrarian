# == Schema Information
#
# Table name: soldiers
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  description             :string(255)
#  attack_min              :integer
#  defense_min             :integer
#  hp_min                  :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attack_max              :integer
#  defense_max             :integer
#  hp_max                  :integer
#  level_max               :integer
#  critical_hit_chance_min :integer          default(0), not null
#  critical_hit_chance_max :integer          default(0), not null
#  critical_hit_damage_min :integer          default(0), not null
#  critical_hit_damage_max :integer          default(0), not null
#  dodge_chance_min        :integer          default(0), not null
#  dodge_chance_max        :integer          default(0), not null
#  damage_reduction_min    :integer          default(0), not null
#  damage_reduction_max    :integer          default(0), not null
#

class Soldier < ActiveRecord::Base
end

