class BattleController < ApplicationController
  before_action :authenticate_user!
  def index
    unit_list_a = Array.new
    unit_list_b = Array.new
    enemy1 = Enemy.find(1)
    enemy2 = Enemy.find(1)
    unit_list_a.push(Battle::Unit.new(enemy1))
    unit_list_a.push(Battle::Unit.new(enemy2))
    unit_list_b.push(Battle::Unit.new(PlayerCharacter.new(Player.find_by(user_id: current_user.id))))
    executor = Battle::Executor.new()
    party_a = Battle::Party.new(unit_list_a, "モンスターたち" )
    party_b = Battle::Party.new(unit_list_b, "俺のパーティ")
    @turn_result_list = executor.do_battle(party_a, party_b)
  end
end
