# targetのhpを回復する性質
class Trait::RecoverHpTrait
  attr_reader :failed_message
  def initialize(targets, recover_values)
    @targets = targets
    @recover_values = recover_values

    @modified_targets = []
    @failed_message = nil
  end

  def execute(type, id)
    @targets.each do |target|
      if target.type.to_i == type.to_i && target.id.to_i == id.to_i
        if target.hp == target.hp_max
          @failed_message = target.name + 'は回復する必要ないよ'
          return false
        end

        target.recover_hp(@recover_values)
        @modified_targets.push(target)
        return true
      end
    end
    # だれも何もされなかった。
    if @modified_targets.count == 0
      @failed_message = '正しく選択されてないよ。'
      fail 'no such target: ' + type.to_s + ' id: ' + id.to_s
    end
  end

  def save!
    @modified_targets.each(&:save!)
  end

  def success_message
    message_list = []
    @modified_targets.each do |modified|
      message_list.push(modified.name + 'のHPを回復しました。')
    end
    return message_list
  end

  def targets
    if @trait_targets
      return @trait_targets
    end

    @trait_targets = []
    @targets.each do |target|
      @trait_targets.push(Trait::RecoverHpTraitTarget.new(target))
    end
    return @trait_targets
  end

  class Trait::RecoverHpTraitTarget < Trait::TraitTargetBase
    attr_reader :parameters
    def initialize(target)
      @target = target
      @parameters = []
      @parameters.push({name: 'target_type', value: @target.type})
      @parameters.push({name: 'target_id', value: @target.id})
    end

    def get_view
      return "#{@target.name} ( #{@target.hp} / #{@target.hp_max} )"
    end
  end
end

