class Player < ActiveRecord::Base
  has_one :user_area, dependent: :destroy
  has_many :town_bulletin_boards, dependent: :destroy
  belongs_to :user
end
