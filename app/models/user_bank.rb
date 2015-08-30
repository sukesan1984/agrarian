# == Schema Information
#
# Table name: user_banks
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  rails      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_banks_on_player_id  (player_id) UNIQUE
#

class UserBank < ActiveRecord::Base
  belongs_to :player
  def self.get_or_new(player_id)
    user_bank = UserBank.find_by(player_id: player_id)
    if user_bank.nil?
      user_bank = UserBank.new(
        player_id: player_id,
        rails: 0
      )
    end
    return user_bank
  end

  def has_enough_rails?(value)
    return false unless value.is_a?(Integer)
    return self.rails >= value
  end

  def add_rails(value)
    return false unless value.is_a?(Integer)
    self.set_current(self.rails + value)
  end

  def set_current(value)
    if value < 0
      self.rails = 0
      return
    end
    self.rails = value
  end
end
