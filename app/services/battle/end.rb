# バトル終了処理
class Battle::End
  attr_reader :given_exp_result
  def initialize(winner_party, defeated_party, player_character)
    @winner_party = winner_party
    @defeated_party   = defeated_party
    @player_character = player_character
    @given_exp_result = []
    # @item_list = []
  end

  def give_rails
    @added_rails = @defeated_party.total_rails
    @player_character.give_rails(@added_rails)
  end

  def give_exp
    @get_exp = @defeated_party.total_exp
    @given_exp_result = @winner_party.give_exp(@defeated_party.total_exp)
  end

  def give_items
    @item_list = @defeated_party.drop_item_list
    @item_list.each(&:give)
    return @item_list
  end

  def item_list
    return @item_list
  end

  def result
    # TODO: この辺リファクタ
    return @get_exp.to_s + 'の経験値と' + @added_rails.to_s + 'rails を獲得した'
  end

  def save!
    @player_character.save!
    @winner_party.save!
    @item_list.each(&:save!)
  end
end

