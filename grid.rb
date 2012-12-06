require_relative "cell"

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
