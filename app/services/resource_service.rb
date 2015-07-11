class ResourceService
  def initialize(resource, resource_keeper)
    @resource = resource
    @resource_keeper = resource_keeper
  end
  
  # 現在の数を取得する。
  def current_count
    # 今の数＋最後に回復した時間からの経過時間 / 回復速度時間 * 単位回復量
    # 最後に回復した時間がなければ、今の数
    if(@resource_keeper.last_recovered_at == nil)
      return @resource_keeper.current_count
    end
    # 経過時間(s)
    passed_time = Time.now - @resource_keeper.last_recovered_at
    recovered_count = (passed_time / @resource.recover_interval * @resource.recover_count).to_i

    # 回復後の値
    after = @resource_keeper.current_count + recovered_count
    if(after > @resource.max_count)
      return @resource.max_count
    end

    return after
  end

  # 現在の数と最後に回復した時間を取得する。
  def save 
    @resource_keeper.last_recovered_at = Time.now
    @resource_keeper.current_count = self.current_count
    @resource_keeper.save
  end
end
