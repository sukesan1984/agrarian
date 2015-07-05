class Battle::Executor
  # partyはcharacterで。
  def do_battle(party_a, party_b)
    action_list = Array.new()

    action_list.push(party_a.get_action(party_b))
    action_list.push(party_b.get_action(party_a))

    return action_list
  end
end
