class EstablishmentFactory
  def initialize
  end

  def build_by_town_id(town_id)
    establishments = Establishment.where("town_id = ?", town_id)
    list = Array.new
    establishments.each do |establishment|
      list.push(build_by_establishment(establishment))
    end
    return list
  end

  private
  def build_by_establishment(establishment)
    case establishment.establishment_type
    # ショップ
    when 1
      shop = Shop.find_by(id: establishment.establishment_id)
      return shop
    end
  end
end
