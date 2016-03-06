# バトルを終了させるサービス
class Battle::TerminatingBattleService
  def initialize(result, party_a, party_b, player_character, death_penalty, enemy_group_entity)
    @result = result

    @party_a = party_a
    @party_b = party_b

    @player_character = player_character
    @enemy_group_entity = enemy_group_entity
    @death_penalty = death_penalty
    @terminating_service = self.get_terminating_service
  end

  # それぞれのケースでサービスをセットアップする
  def get_terminating_service
    if @result.is_draw
      return TerminatingDrawService.new(@party_a, @party_b)
    end

    if @result.is_winner(@party_a)
      return TerminatingWinningService.new(@party_a, @party_b, @player_character, @enemy_group_entity)
    else
      return TerminatingLosingService.new(@party_a, @party_b, @death_penalty, @player_character, @enemy_group_entity)
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
    return @terminating_service.result
  end

  def given_exp_result
    return @terminating_service.given_exp_result
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

    def given_exp_result
      return []
    end

    def result
      return ""
    end 
  end

  class TerminatingWinningService
    def initialize(winner_party, defeated_party, player_character, enemy_group_entity)
      @winner_party = winner_party
      @defeated_party = defeated_party
      @player_character = player_character
      @enemy_group_entity = enemy_group_entity
    end

    def terminate
      self.give_rails
      self.give_exp
      self.give_items
      @enemy_group_entity.make_unencountered
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
      @enemy_group_entity.save!
    end

    def item_list
      return @item_list
    end

    def given_exp_result
      return @given_exp_result
    end

    def result
    # TODO: この辺リファクタ
      return @get_exp.to_s + 'の経験値と' + @added_rails.to_s + 'rails を獲得した'
    end
  end

  class TerminatingLosingService
    def initialize(party_a, party_b, death_penalty, player_character, enemy_group_entity)
      @party_a = party_a
      @party_b = party_b
      @player_character = player_character
      @death_penalty = death_penalty
      @enemy_group_entity = enemy_group_entity
    end

    def terminate
      @death_penalty.give_death_penalty
      @enemy_group_entity.make_unencountered
    end

    def item_list
      return nil 
    end

    def save!
      @party_a.save!
      @party_b.save!
      @death_penalty.save!
      @enemy_group_entity.save!
    end

    def result
      return ""
    end

    def given_exp_result
      return []
    end
  end
end

