class Battle::Result
  attr_reader :turn_result_list
  def initialize(turn_result_list)
    @turn_result_list = turn_result_list
  end
end
