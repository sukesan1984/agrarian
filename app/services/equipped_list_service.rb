# ある人の装備全体
class EquippedListService
  attr_accessor :right_hand, :left_hand, :both_hand, :head, :body, :leg
  def initialize(equipment_model:, right_hand:, left_hand:, both_hand:, head:, body:, leg:)
    Rails.logger.debug(right_hand)
    @equipment_model = equipment_model
    @right_hand = right_hand
    @left_hand = left_hand
    @both_hand = both_hand
    @head = head
    @body = body
    @leg = leg
    @modified = {}
  end

  def list
    return [
      @head,
      @right_hand,
      @left_hand,
      @body,
      @leg
    ]
  end

  # equipped_service
  def exchange(equipped_service)
    equip_target_body_part(equipped_service)
  end

  # 対象のuser_itemを装備しているか
  def equipped(user_item_id)
    return @equipment_model.right_hand.to_i == user_item_id.to_i ||
      @equipment_model.left_hand.to_i == user_item_id.to_i ||
      @equipment_model.head.to_i == user_item_id.to_i ||
      @equipment_model.body.to_i == user_item_id.to_i ||
      @equipment_model.leg.to_i == user_item_id.to_i
  end

  def unequip(user_item_id)
    BodyRegion.get_list.each do |part|
      body_part_name = part.variable_name
      if @equipment_model.send(body_part_name).to_i == user_item_id.to_i
        unequip_target_body_part(send(body_part_name))
        return
      end
    end
    fail 'no item equipped: ' + user_item_id.to_s
  end

  # 全ての装備を外す
  def unequip_all
    BodyRegion.get_list.each do |part|
      body_part_name = part.variable_name
      unequip_target_body_part(send(body_part_name))
    end
  end

  def status
    return list.inject(Status.new(0, 0, 0, 0, 0, 0)) { |sum, equipment_entity| sum + equipment_entity.status }
  end

  def save!
    @equipment_model.save!
    list.each(&:save!)
    @modified.each do|part_id, body_part|
      Rails.logger.debug("#{part_id} : #{body_part}")
      if body_part
        body_part.save!
        # saveしたら、modifiedはnilにする。
        @modified[part_id] = nil
      end
    end
  end

  private

  def equip_target_body_part(equipped_service)
    equipped_service.set_equipped(true)
    body_part = send(equipped_service.part_variable_name)
    body_part.set_equipped(false)
    body_part = equipped_service
    @equipment_model.send("#{equipped_service.part_variable_name}=", equipped_service.user_item_id)
  end

  def unequip_target_body_part(body_part)
    body_part.set_equipped(false)
    @modified[body_part.part_id] = body_part
    send("#{body_part.part_variable_name}=", EquippedService.new(BodyRegion.get_by_variable_name(body_part.part_variable_name), nil))
    @equipment_model.send("#{body_part.part_variable_name}=", 0)
  end
end

