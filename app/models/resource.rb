class Resource < ActiveRecord::Base
  has_one :nature_field
  belongs_to :item
end