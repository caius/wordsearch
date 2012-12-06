require_relative "grid"
require_relative "strategies"

grid = Grid.new(10, 10)
Strategy::Horizontal.place "caius", on: grid
Strategy::Horizontal.place "durling", on: grid
print grid.to_s
