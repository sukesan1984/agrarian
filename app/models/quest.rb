# == Schema Information
#
# Table name: quests
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  reward_gift_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Quest < ActiveRecord::Base
end

