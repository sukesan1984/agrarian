# バトルを終了させるサービス
class Battle::TerminatingBattleService
  attr_reader :given_exp_result
  def initialize(result, party_a, party_b, player_character, death_penalty)
    @result = result

    @party_a = party_a
    @party_b = party_b

    @player_character = player_character
    @given_exp_result = []
    @terminating_service = self.get_terminating_service
  end

  # それぞれのケースでサービスをセットアップする
  def get_terminating_service
    if @result.is_draw
      return TerminatingDrawService.new(@party_a, @party_b)
    end

    if @result.is_winner(@party_a)
      return TerminatingWinningService.new(@party_a, @party_b, @player_character)
    else
      return TerminatingLosingService.new(@death_penalty)
    end
  end

  def terminate
    ActiveRecord::Base.transaction do
      @terminating_service.terminate
      @terminating_service.save!
    end
  rescue => e
    raise e
  end

  def item_list
    return @terminating_service.item_list
  end

  def result
    # TODO: この辺リファクタ
    return @get_exp.to_s + 'の経験値と' + @added_rails.to_s + 'rails を獲得した'
  end


  class TerminatingDrawService
    def initialize(party_a, party_b)
      @party_a = party_a
      @party_b = party_b
    end

    def terminate
      self.save!
    end

    def item_list
      return nil
    end

    def save!
      @party_a.save!
      @party_b.save!
    end
  end

  class TerminatingWinningService
    def initialize(winner_party, defeated_party, player_character)
      @winner_party = winner_party
      @defeated_party = defeated_party
      @player_character = player_character
    end

    def terminate
      self.give_rails
      self.give_exp
      self.give_items
      @user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: @player_character.id)
      # 自分だけの時は消す 
      if UserEncounterEnemyGroup.where(enemy_group_id: @user_encounter_enemy_group.enemy_group_id).count == 1
        EnemyGroup.delete_all(id: @user_encounter_enemy_group.enemy_group_id)
        enemy_instances = EnemyInstance.where(enemy_group_id: @user_encounter_enemy_group.enemy_group_id)
        enemy_instances.each(&:destroy)
      end
      @user_encounter_enemy_group.enemy_group_id = 0
    end

    def give_rails
      @added_rails = @defeated_party.total_rails
      @player_character.give_rails(@added_rails)
    end

    def give_exp
      @get_exp = @defeated_party.total_exp
      @given_exp_result = @winner_party.give_exp(@defeated_party.total_exp)
    end

    def give_items
      @item_list = @defeated_party.drop_item_list
      @item_list.each(&:give)
      return @item_list
    end

    def save!
      @player_character.save!
      @winner_party.save!
      @item_list.each(&:save!)
      @user_encounter_enemy_group.save!
    end

    def item_list
      return @item_list
    end
  end

  class TerminatingLosingService
    def initialize(party_a, party_b, death_penalty, player_character)
      @party_a = party_a
      @party_b = party_b
      @player_character = player_character
      @death_penalty = death_penalty
    end

    def terminate
      @death_penalty.give_death_penalty
      @user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: @player_character.id)
      # 自分だけの時は消す 
      if UserEncounterEnemyGroup.where(enemy_group_id: @user_encounter_enemy_group.enemy_group_id).count == 1
        EnemyGroup.delete_all(id: @user_encounter_enemy_group.enemy_group_id)
        enemy_instances = EnemyInstance.where(enemy_group_id: @user_encounter_enemy_group.enemy_group_id)
        enemy_instances.each(&:destroy)
      end
      @user_encounter_enemy_group.enemy_group_id = 0
    end

    def item_list
      return nil 
    end

    def save!
      @party_a.save!
      @party_b.save!
      @death_penalty.save!
      @user_encounter_enemy_group.save!
    end
  end
end

