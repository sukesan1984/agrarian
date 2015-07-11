class AreaType::Base
  # 名前を取得する。
  def get_name()
  end

  def get_render_path()
  end

  def is_nil
    return false
  end

  def next_to_area_node_id
  end

  def has_action
    return false
  end

  def action
    return nil
  end 
end
