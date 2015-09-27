class Entity::Trait::MoveTraitEntity
  attr_reader :failed_message, :success_message
  def initialize(user_area, targets)
    @user_area = user_area
    @targets = targets
    @failed_message = nil
    @success_message = nil
  end

  def targets
    if @trait_targets
      return @trait_targets
    end

    @trait_targets = []

    @targets.each do |target|
      @trait_targets.push(Entity::Trait::MoveTraitEntityTarget.new(target))
    end

    return @trait_targets
  end

  # moveでは、target_typeは使わない
  def execute(target_type, target_id)
    # TODO: エンモルドは未実装
    cant_move_areas = [3,5,6,7]
    if cant_move_areas.include?(target_id.to_i)
      @failed_message = 'ごめん。まだいかれへんねん'
      return false
    end

    town = Town.find_by(id: target_id)
    unless town
      @failed_message = 'そんな街あらへんわ'
      return false
    end

    # TODO: ハードコードやめる
    area = Area.find_by(area_type: 1, type_id: town.id)
    unless area
      @failed_message = "#{town.name}に該当するエリアないわ.多分バグやわごめん"
      return false
    end

    # 街は基本的にnode_point1の筈だから、1レコード
    area_node = AreaNode.find_by(area_id: area.id)
    unless area_node
      @failed_message = "#{town.name}に該当するAreaNodeないわ。多分バグ・・・"
      return false
    end

    @user_area.area_node_id = area_node.id

    @success_message = "#{town.name}に移動した"

    return true
  end

  def save!
    @user_area.save!
  end

  class Entity::Trait::MoveTraitEntityTarget < Entity::Trait::TraitTargetBaseEntity
    attr_reader :parameters
    def initialize(target)
      @target = target
      @parameters = []
      @parameters.push({name: 'target_id', value: @target.id })
    end

    def get_view
      return @target.name
    end

    def get_use_message
      return '移動する'
    end
  end
end
