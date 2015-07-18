# == Schema Information
#
# Table name: towns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Town < ActiveRecord::Base
  has_many :town_bulletin_boards, dependent: :destroy
  has_many :establishments
end
