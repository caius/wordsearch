class Strategy
  PlaceError = Class.new(StandardError)

  class Base
    attr_accessor :grid, :word

    def initialize word, grid
      self.word = word
      self.grid = grid
    end

    def self.place word, opts={}
      grid = opts.fetch(:on)
      new(word, grid).call
    end

    def call
      raise NotImplementedError, "override in subclass #{self}"
    end

    def place_word_at coords
      raise ArgumentError, "Not enough co-ordinates" unless coords == (word.size - 1)
      coords.each_with_index do |c, i|
        c.value = word[i]
      end
    end
  end

  class Horizontal < Base
    def call
      raise PlaceError, "word too wide for grid" if grid.width < word.length

      grid.width.times do |x|
        grid.height.times do |y|
          pending_cells = word.length.times.map {|i| grid.cell_at((x + i), y) }
          next if pending_cells.any? &:filled?

          # Otherwise we're good to go
          pending_cells.each_with_index do |cell, i|
            cell.value = word[i]
          end
          return
        end
      end
    end
  end

  class Vertical < Base
    def call
      raise PlaceError, "word too wide for grid" if grid.width < word.length
      plausible = []

      grid.height.times do |y|
        grid.width.times do |x|
          pending_cells = word.length.times.map {|i| grid.cell_at(x, (y + i)) }
          next if pending_cells.any? {|c| c && c.filled? }

          plausible << pending_cells
        end
      end

      # Choose random location!
      place_word_at plausible.sample
    end
  end

end
