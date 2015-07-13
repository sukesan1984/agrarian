class ItemAbilityList < ActiveRecord::Base
  belongs_to :item_ability
  belongs_to :item
end
