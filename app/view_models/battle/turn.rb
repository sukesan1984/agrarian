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

    action_list.push(@party_a.get_action(@party_b))
    action_list.push(@party_b.get_action(@party_a))

    is_turn_end = @party_a.is_dead || @party_b.is_dead
    @current_turn += 1

    return Battle::TurnResult.new(action_list, @current_turn, is_turn_end)
  end
end

class Battle::TurnResult
  def initialize(action_list, turn_count, is_turn_end)
    @action_list = action_list
    @is_turn_end = is_turn_end
    @turn_count  = turn_count
  end

  def get_action_list()
    return @action_list
  end

  def is_turn_end()
    return @is_turn_end
  end

  def get_turn_count()
    return @turn_count
  end
end
