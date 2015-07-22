class AreaType::Base
  # 名前を取得する。
  def get_name
  end

  def get_render_path
  end

  def is_nil
    return false
  end

  def next_to_area_node_id
  end

  def has_resource_action
    return false
  end

  def resource_action_execute
  end

  # areaに応じた固有のアクションを実行する
  def execute
  end

  def can_move_to_next
    return true
  end
end

