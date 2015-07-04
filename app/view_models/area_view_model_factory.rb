class AreaViewModelFactory
  def build(area_type, type_id)
    case area_type
    when 1
      return TownViewModel.new(type_id)
    when 2
      return RoadViewModel.new(type_id)
    end
  end
end
