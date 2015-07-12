class Resource < ActiveRecord::Base
  has_one :nature_field
  has_many :showcases
  belongs_to :item
end
