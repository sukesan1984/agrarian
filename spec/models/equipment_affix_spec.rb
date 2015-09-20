# == Schema Information
#
# Table name: equipment_affixes
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  equipment_type         :integer
#  affix_group            :integer
#  affix_type             :integer
#  rarity                 :integer
#  damage_perc_min        :integer
#  damage_perc_max        :integer
#  attack_rating_perc_min :integer
#  attack_rating_perc_max :integer
#  defense_perc_min       :integer
#  defense_perc_max       :integer
#  hp_min                 :integer
#  hp_max                 :integer
#  hp_steal_perc_min      :integer
#  hp_steal_perc_max      :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe EquipmentAffix, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
