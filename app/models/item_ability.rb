class ItemAbility < ActiveRecord::Base
  has_many :item_ability_lists
  has_one :harvest
end
