class Entity::UserAffixListEntity
  def initialize(user_affixes)
    @user_affixes = user_affixes
  end

  # 名前を結合して、返す
  def name
    return "" unless @user_affixes
    @user_affixes.each do |user_affix|
    end
  end
end
