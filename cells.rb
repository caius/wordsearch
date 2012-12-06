require "set"

class Grid
  attr_accessor :width, :height

  def initialize width, height
    self.width = width
    self.height = height
  end

  def cells
    @cells ||= Array.new(width) do |x|
      Array.new(height) { |y| Cell.new(x, y) }
    end.flatten
  end

  def cell_at x, y
    cells.find {|c| c.x == x && c.y == y }
  end

  def to_s
    o = ""
    width.times do |x|
      height.times do |y|
        o << self.cell_at(x, y).value + " "
      end
      o << "\n"
    end
    o
  end
end

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
    (defined?(@value) && @value) || generated_value
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

grid = Grid.new(10, 10)
print grid.to_s
