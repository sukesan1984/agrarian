require 'rails_helper'

RSpec.describe Entity::UserEquipmentAffixListEntity do
  let(:user_equipment_prefix) { create(:user_equipment_affix, equipment_affix_id: 1000011, damage_perc: 15 ) }
  let(:user_equipment_suffix) { create(:user_equipment_affix, equipment_affix_id: 2000041, hp: 3) }

  describe "name" do
    it 'name' do
      user_affixes = []
      user_affixes.push(user_equipment_prefix)
      user_affixes.push(user_equipment_suffix)
      list = Entity::UserEquipmentAffixListEntity.new(user_affixes)
      expect(list.name).to eq '荒削りのジャッカル風'
    end
  end

  describe "status" do
    it 'status' do
      user_affixes = []
      user_affixes.push(user_equipment_prefix)
      user_affixes.push(user_equipment_suffix)
      list = Entity::UserEquipmentAffixListEntity.new(user_affixes)
      expect(list.status.damage_perc).to eq 15
      expect(list.status.hp).to eq 3
    end
  end
end
