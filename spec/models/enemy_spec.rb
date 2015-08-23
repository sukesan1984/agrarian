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

require 'rails_helper'

RSpec.describe Enemy, type: :model do
  it 'has_one :enemy_map test' do
    is_expected.to have_one(:enemy_map)
  end
end

