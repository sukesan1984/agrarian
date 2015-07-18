class Battle::Executor
  # partyはcharacterで。
  def do_battle(party_a, party_b)
    turn = Battle::Turn.new(party_a, party_b)

    turn_result_list = Array.new()
    is_battle_end = false

    while(!is_battle_end)
      turn_result = turn.do_battle()
      turn_result_list.push(turn_result)
      is_battle_end = turn_result.is_battle_end
    end

    return Battle::Result.new(turn_result_list)
  end

end
