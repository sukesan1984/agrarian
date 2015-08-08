class Battle::Party
  attr_reader :name
  def initialize(unit_list, name)
    @unit_list = unit_list
    @name      = name
  end

  # パーティが全滅しているかどうかを返す。
  def is_dead
    @unit_list.each do |unit|
      # 一人でも死んでなかったらfalse
      return false if (unit.is_dead == false)
    end

    return true
  end

  # まだ行動してなくて、死んでないユニットを取得する。
  # TODO: 素早さとかでソートする？
  def get_actionable_unit
    @unit_list.each do |unit|
      return unit if !unit.is_dead && !unit.done_action
    end

    return nil
  end

  # 攻撃対象を取得する。
  def get_attackable_unit
    attackable_units = []
    @unit_list.each do |unit|
      attackable_units.push(unit) unless unit.is_dead
    end
    return nil if (attackable_units.count == 0)

    return attackable_units.sample(1).first
  end

  # パーティを全員行動させる
  # TODO: unit = character
  def do_action(party)
    action_list = []

    unit = get_actionable_unit
    until unit.nil?
      action = unit.get_action(party)
      action_list.push(action) unless action.nil?
      unit.done_action = true
      unit = get_actionable_unit
    end

    return action_list
  end

  # 行動済みfalseにする。
  def reset_done_action
    @unit_list.each do |unit|
      unit.done_action = false
    end
  end

  # パーティ全員の状態を取得する。
  def current_status_list
    state_list = []
    @unit_list.each do |unit|
      state_list.push(unit.get_current_state)
    end

    return state_list
  end

  def total_rails
    return @unit_list.inject(0) { |sum, unit| sum + unit.rails }
  end

  def total_exp
    return @unit_list.inject(0) { |sum, unit| sum + unit.exp }
  end

  def give_exp(exp)
    given_exp = (exp / @unit_list.count).ceil
    @unit_list.each do |unit|
      unit.give_exp(given_exp)
    end
  end

  # 永続化する必要があるメンバーがいれば永続化する
  def save!
    @unit_list.each(&:save!)
  end
end

