class BattleController < ApplicationController
  before_action :authenticate_user!
  def index
    area_id = params[:area_id]

    enemy_maps = EnemyMap.where("area_id = ?", area_id)
    if(enemy_maps.count == 0)
      redirect_to("/")
      return 
    end

    enemies_lottery = Battle::EnemiesLottery.new(enemy_maps)

    player_character_factory = PlayerCharacterFactory.new
    player_character = player_character_factory.build_by_user_id(current_user.id)
    unit_list_a = Array.new
    unit_list_b = Array.new

    list = enemies_lottery.lot(rand(1..3))
    list.each do |enemy|
      unit_list_a.push(Battle::Unit.new(EnemyCharacter.new(enemy)))
    end

    unit_list_b.push(Battle::Unit.new(player_character))
    executor = Battle::Executor.new()
    party_a = Battle::Party.new(unit_list_a, "モンスターたち" )
    party_b = Battle::Party.new(unit_list_b, "俺のパーティ")
    @turn_result_list = executor.do_battle(party_a, party_b)
    party_a.save
    party_b.save
  end
end
