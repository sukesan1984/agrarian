class BattleController < ApplicationController
  before_action :authenticate_user!
  def index
    area_id = params[:area_id]

    player_character_factory = PlayerCharacterFactory.new
    player_character = player_character_factory.build_by_user_id(current_user.id)

    user_area  = UserArea.get_or_create(player_character.id)

    @death_penalty = DeathPenalty.new(player_character, user_area)

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
    unit_list_b.push(Battle::Unit.new(SoldierCharacter.new(Soldier.find_by(id: 1))))
    executor = Battle::Executor.new()
    party_a = Battle::Party.new(unit_list_a, "モンスターたち" )
    party_b = Battle::Party.new(unit_list_b, "俺のパーティ")
    @result = executor.do_battle(party_a, party_b)

    ActiveRecord::Base.transaction do
      UserEncounterEnemy.delete_all(["player_id = ?", player_character.id])
      # 敵が勝利した
      if(@result.is_winner(party_a))
        @death_penalty.execute
        @death_penalty.save!
      end
      party_a.save
      party_b.save
    end
    rescue => e
      logger.debug(e)
  end
end
