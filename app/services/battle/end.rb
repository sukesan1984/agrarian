# バトル終了処理
class Battle::End
  def initialize(winner_party, defeated_party, player_character)
    @winner_party = winner_party
    @defeated_party   = defeated_party
    @player_character = player_character
  end

  def give_rails
    @added_rails = @defeated_party.total_rails
    @player_character.give_rails(@added_rails)
  end

  def give_exp
    @get_exp = @defeated_party.total_exp
    @winner_party.give_exp(@defeated_party.total_exp)
  end

  def result
    # TODO: この辺リファクタ
    return @get_exp.to_s + 'の経験値と' + @added_rails.to_s + 'rails を獲得した'
  end

  def save!
    @player_character.save!
    @winner_party.save!
  end
end

