# == Schema Information
#
# Table name: user_equipment_affixes
#
#  id                 :integer          not null, primary key
#  user_item_id       :integer
#  equipment_affix_id :integer
#  damage_perc        :integer          default(0)
#  attack_rating_perc :integer          default(0)
#  defense_perc       :integer          default(0)
#  hp                 :integer          default(0)
#  hp_steal_perc      :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_user_equipment_affixes_on_user_item_id  (user_item_id)
#

require 'rails_helper'

RSpec.describe UserEquipmentAffix, type: :model do
end
