class Player < ActiveRecord::Base
  has_one :user_area, dependent: :destroy
  belongs_to :user
end
