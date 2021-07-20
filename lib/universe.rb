require_relative './cell'


class Universe
  attr_accessor :cells, :size
  def initialize(size = 25)
    @size = size
    @cells = []
    (0...size).each do |x|
      cells << []
      (0...size).each do |y|
        cells[x] << Cell.new(x, y, self)
      end
    end
  end

  def seed(points)
    points.each do |point|
      next unless inside_the_universe(*point)
      cell_at(*point).live = true
    end
  end

  def next_generation
    next_state = Array.new(size).map{ Array.new(size, nil) }
    cells.flatten.each do |cell|
      x, y = cell.x, cell.y
      new_cell = Cell.new(x, y, self)
      new_cell.live = cell.next_state
      next_state[x][y] = new_cell
    end
    @cells = next_state
    return cells
  end

  def to_table
    cells.map do |r|
      r.map do |c|
        c.live ? "\u2764" : "."
      end.join(" ")
    end.join("\n")
  end

  def start_game(limit = 10)
    puts `clear`
    (0..limit).each do |i|
      next_generation
      puts to_table
      sleep 1 
      puts `clear` if i < limit
    end
    return
  end

  private

  def cell_at(x, y)
    cells[x][y]
  end

  def inside_the_universe(x, y)
    x >= 0 && y >= 0 && x < size && y < size
  end
end
