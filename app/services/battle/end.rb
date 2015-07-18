# バトル終了処理
class Battle::End
  def initialize(defeated_party, player_character)
    @defeated_party   = defeated_party
    @player_character = player_character
  end

  def give_rails
    @added_rails = @defeated_party.total_rails
    @player_character.give_rails(@added_rails)
  end

  def result
    # TODO: この辺リファクタ
    return @added_rails.to_s + "rails を獲得した"
  end

  def save!
    @player_character.save!
  end
end

