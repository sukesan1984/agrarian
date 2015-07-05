class BattleController < ApplicationController
  def index
    party_a = Battle::Character.new("スライム", 4, 30)
    party_b = Battle::Character.new("俺", 5, 50)
    executor = Battle::Executor.new()
    @turn_result_list = executor.do_battle(party_a, party_b)
  end
end
