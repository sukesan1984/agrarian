# デスペナを扱うクラス
class DeathPenalty
  attr_reader :result_list, :executed
  def initialize(player_character, user_area)
    @player_character = player_character
    @user_area = user_area
    @result_list = Array.new
    @executed = false
  end

  def execute
    @result_list.push(@player_character.give_death_penalty)
    @result_list.push(@user_area.give_death_penalty)
    @executed = true
  end

  def save!
    @player_character.save!
    @user_area.save!
  end
end
