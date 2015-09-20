require 'rails_helper'

RSpec.describe Entity::UserEquipmentAffixListEntity do
  let(:user_equipment_prefix) { create(:user_equipment_affix, equipment_affix_id: 1000011) }
  let(:user_equipment_suffix) { create(:user_equipment_affix, equipment_affix_id: 2000041) }

  describe "name" do
    it 'name' do
      user_affixes = []
      user_affixes.push(user_equipment_prefix)
      user_affixes.push(user_equipment_suffix)
      list = Entity::UserEquipmentAffixListEntity.new(user_affixes)
      expect(list.name).to eq '荒削りのジャッカル風'
    end
  end
end
