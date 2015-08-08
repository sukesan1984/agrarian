# == Schema Information
#
# Table name: enemies
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  attack      :integer
#  defense     :integer
#  hp          :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string(255)
#  rails       :integer
#  exp         :integer
#

class Enemy < ActiveRecord::Base
  has_one :enemy_map
end

