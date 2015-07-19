# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hp         :integer          default(50)
#  hp_max     :integer          default(50)
#  rails      :integer          default(300)
#
# Indexes
#
#  index_players_on_user_id  (user_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to have_one(:user_area) }
  it { is_expected.to have_many(:town_bulletin_boards) }
  it { is_expected.to belong_to(:user) }
end
