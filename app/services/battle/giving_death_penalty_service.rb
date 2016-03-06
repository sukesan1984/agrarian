# デスペナを扱うクラス
class Battle::GivingDeathPenaltyService
  attr_reader :result_list, :executed
  def initialize(player_character, user_area, dungeon_entity)
    @player_character = player_character
    @user_area = user_area
    @dungeon_entity = dungeon_entity
    @result_list = []
    @executed = false
  end

  def execute
    @result_list.push(@player_character.give_death_penalty)
    @result_list.push(@user_area.give_death_penalty)
    if @dungeon_entity
      @result_list.push(@dungeon_entity.give_death_penalty)
    end
    @executed = true
  end

  def save!
    @player_character.save!
    @user_area.save!
    if @dungeon_entity
      @dungeon_entity.save!
    end
  end
end

