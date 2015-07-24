# == Schema Information
#
# Table name: gifts
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Gift < ActiveRecord::Base
end
