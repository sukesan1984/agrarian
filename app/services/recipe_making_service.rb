class RecipeMakingService
  def initialize(recipe, required_user_items, product_item_entity, user_skill)
    @recipe = recipe
    @required_user_items = required_user_items
    @product_item_entity = product_item_entity
    @user_skill = user_skill
  end

  # レシピに従って、製品を作る
  def execute
    ActiveRecord::Base.transaction do
      # 数を減らす
      saved_array = []
      @recipe.required_items.each do |required_item|
        user_item = @required_user_items.get(required_item.item_id)
        # 数が足りなければ、false
        if user_item.count < required_item.count
          return { success: false, message: '数が足りません ' }
        end
        user_item.count -= required_item.count
        saved_array.push(user_item)
      end

      # 成功率の計算
      unless is_success(@user_skill.real_skill_point, @recipe.difficulty)
        saved_array.each do |saved_object|
          saved_object.save!
        end
        return { success: false, message: '失敗しました。素材がなくなりました' }
      end

      if @recipe.product_item.item_id != @product_item_entity.item_id
        fail 'user_item is invalid: ' + @product_item_entity.item_id
      end

      # 成功したら
      skill_increase = @user_skill.try_increase(@recipe.difficulty)
      @product_item_entity.give
      saved_array.push(@product_item_entity)
      message = "#{@product_item_entity.name}を#{@recipe.product_item.count}を手に入れた。"
      if skill_increase > 0
        message += "#{@user_skill.skill.name}のスキル値が#{skill_increase}上昇した。今は#{@user_skill.real_skill_point}。"
        saved_array.push(@user_skill)
      end

      saved_array.each do |saved_object|
        saved_object.save!
      end

      return { success: true, message: message }
    end
  rescue => e
    raise e
  end

  def is_success(real_skill_point, difficulty)
    rate = RecipeMakingService.calculate_successable_rate(real_skill_point, difficulty)
    seed = rand(0.0...100.0)

    Rails.logger.debug("rate: #{rate}, seed: #{seed}")
    return rate > seed
  end

  def self.calculate_successable_rate(real_skill_point, difficulty)
    return 100 if real_skill_point > difficulty

    return 100 * 2**((real_skill_point - difficulty) / 10)
  end
end

