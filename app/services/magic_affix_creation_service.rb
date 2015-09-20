# マジックアイテムのaffix生成してくれるサービス
class MagicAffixCreationService
  def initialize(equipment_entity)
    @equipment_entity = equipment_entity
  end

  # 装備をマジックアイテムにする
  def apply_magic(item_rarity)
    # すでに持っていたら何もしない。
    return if @equipment_entity.has_affixes

    ActiveRecord::Base.transaction do

      affixes = MagicAffixCreationService::get_affixes(item_rarity)
      user_equipment_affixes = []
      affixes.each do |affix|
        affix_value = affix.get_random_value
        user_equipment_affix = UserEquipmentAffix.new(
          user_item_id: @equipment_entity.user_item_id,
          equipment_affix_id: affix.id)
        affix_value.each do |key, value|
          user_equipment_affix.send("#{key}=", value)
        end
        user_equipment_affixes.push(user_equipment_affix)
      end
      @equipment_entity.apply_magic(user_equipment_affixes)
      @equipment_entity.save!
      return {success: true, message: '成功しました'}
    end
  rescue => e
    Rails.logger.debug(e)
    return {success: false, message: '失敗しました'}
  end

  def self.get_affixes(item_rarity)
    random_seed = rand(0...100)
    affixes = []

    if(random_seed < 25)
      affixes.push(self.get_prefix(item_rarity))
      affixes.push(self.get_suffix(item_rarity))
    elsif(random_seed < 50)
      affixes.push(self.get_prefix(item_rarity))
    else
      affixes.push(self.get_suffix(item_rarity))
    end

    return affixes
  end

  # とりあえず、与えられたitem_rarityよりも小さなrarityのものから一つランダムで選ばれるようにしておく。
  # 装備タイプによる出し分けは後でやる
  def self.get_prefix(item_rarity)
    return EquipmentAffix.get_one_random_prefix(item_rarity)
  end

  def self.get_suffix(item_rarity)
    return EquipmentAffix.get_one_random_suffix(item_rarity)
  end
end
