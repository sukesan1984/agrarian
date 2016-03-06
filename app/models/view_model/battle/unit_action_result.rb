class ViewModel::Battle::UnitActionResult
  attr_reader :result
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
    @result = to_string
  end

  def to_string
    return @subject_character.name + 'が' + @object_character.name + 'に' + @value.to_s + 'の' + @verb + '。' + @object_character.name + 'の現在HP: ' + @object_character.hp.to_s
  end
end

