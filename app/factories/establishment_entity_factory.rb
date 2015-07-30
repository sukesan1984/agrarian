class EstablishmentEntityFactory
  def initialize
  end

  def build_by_town_id(town_id)
    establishments = Establishment.where('town_id = ?', town_id)
    area = Area.find_by(area_type: 1, type_id: town_id)
    area_node = AreaNode.find_by(area_id: area.id)
    list = []
    establishments.each do |establishment|
      master = build_master_by_establishment(establishment)
      list.push(Entity::EstablishmentEntity.new(establishment, area_node.id, master))
    end
    return list
  end

  private

  def build_master_by_establishment(establishment)
    case establishment.establishment_type
    # ショップ
    when 1
      shop = Shop.find_by(id: establishment.establishment_id)
      return shop
    # 宿屋
    when 2
      inn = Inn.find_by(id: establishment.establishment_id)
      return inn
    end
  end
end

