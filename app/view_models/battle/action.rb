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
    @result = self.to_string()
  end

  def get_result
    return @result
  end

  def to_string
    return @subject_character.get_name() + "が" + @object_character.get_name() + "に" + @value.to_s() + "の" + @verb + "。" + @object_character.get_name() + "の現在HP: " + @object_character.get_hp().to_s()
  end
end
