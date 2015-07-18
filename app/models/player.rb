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

class Player < ActiveRecord::Base
  has_one :user_area, dependent: :destroy
  has_many :town_bulletin_boards, dependent: :destroy
  belongs_to :user
end

