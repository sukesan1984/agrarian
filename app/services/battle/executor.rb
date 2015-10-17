class Battle::Executor
  # partyはcharacterで。
  # 指定ターン数戦う。
  def do_battle(party_a, party_b, turn_count)
    turn = Battle::Turn.new(party_a, party_b)
    if turn_count
      turn_count = turn_count.to_i
      if turn_count <= 0
        turn_count = nil
      end
    end

    turn_result_list = []

    winner_party = nil

    current_turn = 1
    is_in_loop = true
    while is_in_loop
      turn_result = turn.do_battle
      turn_result_list.push(turn_result)
      is_in_loop = !is_battle_end(turn_result, current_turn, turn_count)
      winner_party = turn_result.get_winner if turn_result.is_battle_end
      current_turn += 1
    end

    return Battle::Result.new(turn_result_list, winner_party)
  end

  def is_battle_end(turn_result, current_turn, turn_count)
    # バトルの決着がついたら
    if turn_result.is_battle_end
      return true
    end

    # 規定ターン数が定義されていて、今のターンが規定ターン数を超えたら
    if turn_count && current_turn >= turn_count
      return true
    end

    return false
  end
end

