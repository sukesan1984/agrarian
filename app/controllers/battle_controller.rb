class BattleController < ApplicationController
  def index
    unit_list_a = Array.new
    unit_list_b = Array.new
    unit_list_a.push(Battle::Character.new("スライムA", 4, 10))
    unit_list_a.push(Battle::Character.new("スライムB", 4, 10))
    unit_list_b.push(Battle::Character.new("俺", 5, 50))
    executor = Battle::Executor.new()
    party_a = Battle::Party.new(unit_list_a, "モンスターたち" )
    party_b = Battle::Party.new(unit_list_b, "俺のパーティ")
    @turn_result_list = executor.do_battle(party_a, party_b)
  end
end
