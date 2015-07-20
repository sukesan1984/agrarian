# targetのhpを回復する性質
class Trait::RecoverHpTrait
  def initialize(target, recover_values)
    @target = target
    @recover_values = recover_values
  end

  def execute
    @target.recover_hp(@recover_values)
  end
end
