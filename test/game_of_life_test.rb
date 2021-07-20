require_relative "../lib/cell.rb"
require_relative "../lib/universe.rb"

class GameOfLifeTest
  def self.test_all
    failed_tests = 0
    total_tests = 0
    private_instance_methods.select{|s| s.to_s.start_with?('test_')}.each do |test|
      begin
        total_tests += 1
        GameOfLifeTest.new.send(test) 
      rescue Exception => e
        failed_tests += 1
        puts e.backtrace
        puts "======>>>>"
      end
    end
    puts "#{total_tests} out of #{total_tests-failed_tests} tests passeed"
    raise "#{failed_tests} tests are failing" if failed_tests > 0
  end  

  private

  # tests the first point => Any live cell with fewer than two 
  # live neighbors dies as if caused by underpopulation.
  def test_underpopulation
    seed_cell
    @cell.live = true
    if @cell.next_state
      raise "Cell is not dead with less than two live neighbours"
    end
  end

  # test the second point => Any live cell with two or three live neighbors 
  # lives on to the next generation
  def test_three_live_neighbors
    seed_cell
    @cell.live = true
    set_live_neighbors(2)
    unless @cell.next_state
      raise "Cell should not die with two live neighbours"
    end
  end

  def test_two_live_neighbors
    seed_cell
    @cell.live = true
    set_live_neighbors(3)
    unless @cell.next_state
      raise "Cell should not die with three live neighbours"
    end
  end

  # test the third point => Any live cell with more than three 
  # live neighbors dies, as if by overcrowding.
  def test_overcrowding
    seed_cell(1,1)
    @cell.live = true
    set_live_neighbors(4)
    
    if @cell.next_state
      raise "Cell should not live with more than three live neighbours"
    end
  end

  # test the fouth point => Any dead cell with exactly three live neighbors 
  # becomes a live cell, as if by reproduction.
  def test_reproduction
    seed_cell
    set_live_neighbors(3)
    unless @cell.next_state
      raise "Cell should become live with three live neighbours"
    end

    # should become live if live neighbors are less than 3
    seed_cell
    set_live_neighbors(2)
    if @cell.next_state
      raise "Cell should not live with less than three live neighbours"
    end
  end

  def seed_cell(x = 0,y = 0)
    universe = ::Universe.new(5)
    @cell = Cell.new(x, y, universe)
  end

  def set_live_neighbors(length)
    @cell.send(:neighbours)[0..length-1].each do |cell|
      cell.live = true
    end
  end
end

GameOfLifeTest.test_all
