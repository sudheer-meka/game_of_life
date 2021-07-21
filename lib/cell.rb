# frozen_string_literal: true

class Cell
  DIRECTIONS = [
    [0, -1],
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, 1],
    [1, 1],
    [1, 0],
    [1, -1]
  ].freeze

  attr_accessor :live, :x, :y, :universe_size, :universe

  def initialize(x, y, universe)
    @x = x
    @y = y
    @universe_size = universe.size
    @universe = universe
    @live = false
  end

  def next_state
    case live_neighbours.count
    when 3
      true
    when 2
      live
    else
      false
    end
  end

  private

  def neighbours
    DIRECTIONS.each_with_object([]) do |direction, result|
      nr = x + direction[0]
      nc = y + direction[1]
      result << universe.cells[nr][nc] if inside_the_universe(nr, nc)
    end
  end

  def inside_the_universe(nr, nc)
    nr >= 0 && nc >= 0 && nr < universe_size && nc < universe_size
  end

  def live_neighbours
    neighbours.select(&:live)
  end
end
