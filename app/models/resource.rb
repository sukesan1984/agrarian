# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  recover_count    :integer
#  recover_interval :integer
#  max_count        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string(255)
#  item_id          :integer
#

class Resource < ActiveRecord::Base
  has_one :nature_field
  has_many :showcases
  belongs_to :item
end

