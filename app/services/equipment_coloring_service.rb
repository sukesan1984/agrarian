# 装備品に色を付ける
# つまり、マジックアイテムやレアアイテムなどに変化させるサービス
class EquipmentColoringService
  # 変化させる
  def self.make_equipment_colored(equipment_entity, item_rarity)
    random_seed = rand(0..100)
    if(random_seed < 100)
      MagicAffixCreationService::apply_magic(equipment_entity, item_rarity)
    end
  end
end
