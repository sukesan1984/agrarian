class StatusPoint
  attr_reader :current, :max
  def initialize(current, max)
    @current = current
    @max     = max
  end

  def -(other)
    self.decrease(other)
    return self
  end

  def recover_all
    self.set_current(@max)
  end

  def decrease(value)
    if(!value.is_a?(Integer))
      return
    end
    self.set_current(@current - value)
  end

  def +(other)
    self.increase(other)
    return self
  end

  def increase(value)
    if(!value.is_a?(Integer))
      return
    end
    self.set_current(@current + value)
  end

  def set_current(value)
    if(value > @max)
      @current = @max
      return
    end
    if(value < 0)
      @current = 0
      return
    end
    @current = value
  end
end
