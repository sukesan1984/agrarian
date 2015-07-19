# == Schema Information
#
# Table name: showcases
#
#  id          :integer          not null, primary key
#  shop_id     :integer
#  resource_id :integer
#  cost        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Showcase < ActiveRecord::Base
  belongs_to :shop
  belongs_to :resource
end

