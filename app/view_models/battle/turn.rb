class Battle::Turn
  def initialize(party_a, party_b)
    @party_a = party_a
    @party_b = party_b
    @current_turn = 0
  end

  # ターンを経過させる。
  def do_battle()
    #TODO: 誰が最初に行動するとか
    action_list = Array.new()

    # TODO: party_aがまず全員行動することにしとく
    a_action_list = @party_a.do_action(@party_b)
    b_action_list = @party_b.do_action(@party_a)

    action_list.concat(a_action_list)
    action_list.concat(b_action_list)

    # どちらかのパーティが全滅したらバトル終了
    is_battle_end = @party_a.is_dead || @party_b.is_dead
    @current_turn += 1
    if(!is_battle_end)
      @party_a.reset_done_action
      @party_b.reset_done_action
    end

    return Battle::TurnResult.new(action_list, @current_turn, is_battle_end)
  end
end

class Battle::TurnResult
  attr_reader :action_list, :is_battle_end, :turn_count
  def initialize(action_list, turn_count, is_battle_end)
    @action_list = action_list
    @is_battle_end = is_battle_end
    @turn_count  = turn_count
  end
end
