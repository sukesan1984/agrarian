class Town < ActiveRecord::Base
  has_many :town_bulletin_boards, dependent: :destroy
end
