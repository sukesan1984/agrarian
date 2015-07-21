# targetのhpを回復する性質
class Trait::RecoverHpTrait
  attr_reader :targets, :failed_message
  def initialize(targets, recover_values)
    @targets = targets
    @recover_values = recover_values

    @modified_targets = Array.new
    @failed_message = nil
  end

  def execute(type, id)
    @targets.each do |target|
      if target.type.to_i == type.to_i && target.id.to_i == id.to_i
        if target.hp == target.hp_max
          @failed_message = target.name + "は回復する必要ないよ"
          return false
        end

        target.recover_hp(@recover_values)
        @modified_targets.push(target)
        return true
      end
    end
    # だれも何もされなかった。
    if @modified_targets.count == 0
      @failed_message = "正しく選択されてないよ。"
      raise 'no such target: ' + type.to_s + ' id: ' + id.to_s
    end
  end

  def save!
    @modified_targets.each do |modified|
      modified.save!
    end
  end

  def success_message
    message_list = Array.new
    @modified_targets.each do |modified|
      message_list.push(modified.name + 'のHPを回復しました。')
    end
    return message_list
  end

end
