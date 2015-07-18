class BattleController < ApplicationController
  before_action :authenticate_user!
  def index
    area_id = params[:area_id]

    player_character_factory = PlayerCharacterFactory.new
    player_character = player_character_factory.build_by_user_id(current_user.id)

    user_encounter_enemies = UserEncounterEnemy.where("player_id = ?", player_character.id)
    if(user_encounter_enemies.count == 0)
      render template: "battle/no_enemy"
      return
    end

    unit_list_a = Array.new
    unit_list_b = Array.new

    user_encounter_enemies.each do |user_encounter_enemy|
      unit_list_a.push(Battle::Unit.new(EnemyCharacter.new(user_encounter_enemy.enemy)))
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
