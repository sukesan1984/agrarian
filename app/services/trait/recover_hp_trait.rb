# targetのhpを回復する性質
class Trait::RecoverHpTrait
  attr_reader :targets
  def initialize(targets, recover_values)
    @targets = targets
    @recover_values = recover_values
  end

  def execute
    @target.recover_hp(@recover_values)
  end

end
