# == Schema Information
#
# Table name: equipment
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  body_region :integer
#  attack      :integer
#  defense     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Equipment < ActiveRecord::Base
end

