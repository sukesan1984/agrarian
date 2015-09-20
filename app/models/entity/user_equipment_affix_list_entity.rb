class Entity::UserEquipmentAffixListEntity
  def initialize(user_affixes)
    @user_affixes = user_affixes
  end

  # 名前を結合して、返す
  def name
    return "" unless @user_affixes
    prefix = []
    suffix = []
    @user_affixes.each do |user_affix|
      if user_affix.prefix?
        prefix.push(user_affix.name)
      elsif user_affix.suffix?
        suffix.push(user_affix.name)
      end
    end

    name = prefix.inject(:+)
    name += suffix.inject(:+)

    return name
  end

  def status
    zero_status = Status.new(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) 
    return zero_status unless @user_affixes
    statuses =  @user_affixes.map(&:status).inject(:+)
    return zero_status unless statuses
    return statuses
  end
end
