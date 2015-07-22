class Battle::Result
  attr_reader :turn_result_list
  def initialize(turn_result_list, winner_party)
    @turn_result_list = turn_result_list
    @winner_party = winner_party
  end

  def is_winner(party)
    return party == @winner_party
  end
end

