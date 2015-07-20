class TraitFactory
  def initialize
  end

  def build_by_comsumption_and_target(consumption, target)
    case(consumption.consumption_type)
    when(1)
      return Trait::RecoverHpTrait.new(target, consumption.type_value)
    end
  end
end
