class RecipeMakingService
  def initialize(recipe, required_user_items, product_user_item, user_skill)
    @recipe = recipe
    @required_user_items = required_user_items
    @product_user_item = product_user_item
    @user_skill = user_skill
  end

  # レシピに従って、製品を作る
  def execute
    ActiveRecord::Base.transaction do
      # 数を減らす
      @recipe.required_items.each do |required_item|
        user_item = @required_user_items.get(required_item.item_id)
        # 数が足りなければ、false
        if user_item.count < required_item.count
          return {success:false, message: '数が足りません '}
        end
        user_item.count -= required_item.count
        user_item.save!
      end

      # 成功率の計算
      unless self.is_success(@user_skill.skill_point, @recipe.difficulty)
        return {success:false, message: '失敗しました。素材がなくなりました'}
      end

      if @recipe.product_item.item_id != @product_user_item.item.id
        fail 'user_item is invalid: ' + @product_user_item.item.id
      end

      @product_user_item.count += @recipe.product_item.count
      @product_user_item.save!
      return {success:true, message: "#{@product_user_item.item.name}を#{@recipe.product_item.count}を手に入れた"}
    end
    rescue => e
      raise e
  end

  def is_success(skill_point, difficulty)
    rate = RecipeMakingService.calculate_successable_rate(skill_point, difficulty)
    seed = rand(0.0...100.0)

    Rails.logger.debug("rate: #{rate}, seed: #{seed}")
    return rate > seed
  end

  def self.calculate_successable_rate(skill_point, difficulty)
    if skill_point / 10 > difficulty
      return 100
    end

    return 100 * 2 ** ((skill_point / 10 - difficulty) / 10)
  end
end
