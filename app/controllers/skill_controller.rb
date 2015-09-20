class SkillController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    skills = Skill.all
    skill_ids = skills.map(&:id)
    @user_skills = UserSkill.find_or_create(@player_character.id, skill_ids)
  end

  def set_factories
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

