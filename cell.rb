class Cell
  attr_accessor :x, :y, :value, :generated_value

  def initialize x, y
    self.x = x
    self.y = y
  end

  def generated_value # !> method redefined; discarding old generated_value
    @generated_value ||= ("a".."z").to_a.sample
  end

  def value # !> method redefined; discarding old value
    (defined?(@value) && @value.upcase) || generated_value
  end

  def filled?
    defined?(@value) && @value
  end

  def to_s
    value
  end

  def hash
    [x, y].hash
  end
end
