# キャラクターのステータスを上昇させるサービス
class CharacterStatusIncreaseService
  def initialize(character_entity)
    @character_entity = character_entity
  end

  def increase(status_type, value)
    fail 'value is not integer' unless value.is_a?(Integer)
    fail 'value must be over 0' if value < 0
    fail 'value must be under remaining_points' if value > @character_entity.remaining_points

    ActiveRecord::Base.transaction do
      case status_type.to_i
      when 1
        @character_entity.increase_strength(value)
      when 2
        @character_entity.increase_dexterity(value)
      when 3
        @character_entity.increase_vitality(value)
      when 4
        @character_entity.increase_energy(value)
      else
        fail 'invalid status_type:' + status_type.to_s + ' must be 1, 2, 3, 4'
      end
    end
    @character_entity.save!
  rescue => e
    raise e
  end
end
