class Battle::Action
  # 主体, 客体
  def initialize(
    subject_character,
    object_character,
    verb,
    value)
    @subject_character = subject_character
    @object_character  = object_character
    @verb = verb
    @value = value
  end

  def to_string
    return @subject_character.get_name() + "が" + @object_character.get_name() + "に" + @value.to_s() + "の" + @verb
  end
end
