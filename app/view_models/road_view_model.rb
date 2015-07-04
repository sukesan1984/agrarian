class RoadViewModel < AreaBaseViewModel
  def initialize(type_id)
    @type_id = type_id
  end

  def get_name
    return "道だよ"
  end
end
