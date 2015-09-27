class Entity::Trait::ResetStatusTraitEntity
  def initialize(player_character)
    @player_character = player_character
  end

  def targets
    return [Entity::Trait::ResetStatusTraitEntityTarget.new]
  end

  def execute(type, id)
    @player_character.reset_status_points
    return true
  end

  def success_message
    return "ステータスのリセットに成功しました!!再度振りなおしてください。"
  end

  def save!
    @player_character.save!
  end

  class Entity::Trait::ResetStatusTraitEntityTarget < Entity::Trait::TraitTargetBaseEntity
    attr_reader :parameters
    def initialize
      @parameters = [{}]
    end

    def get_view
      return 'パラメータをリセットして再振り直し可能にします。'
    end

    def get_use_message
      return 'リセットする'
    end
  end
end
