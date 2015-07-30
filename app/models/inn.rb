# == Schema Information
#
# Table name: inns
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  rails       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Inn < ActiveRecord::Base
end
