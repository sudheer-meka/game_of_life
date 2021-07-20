# Game of Life
Definition The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, 
each of which is in one of two possible states, alive or dead. 

Every cell interacts with its eight neighbors, which are the cells that are horizontally, vertically, or diagonally adjacent. 

Rules At each step in time, the following transitions occur: 
  1. Any live cell with fewer than two live neighbors dies as if caused by underpopulation. 
  2. Any live cell with two or three live neighbors lives on to the next generation. 
  3. Any live cell with more than three live neighbors dies, as if by overcrowding. 
  4. Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction. 
  
The initial pattern constitutes the seed of the system. 
The first generation is created by applying the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, 
and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the preceding one). 

The rules continue to be applied repeatedly to create further generations.

Universe can be initialized with
```
  # default size is 25*25 but can pass size as an argument
  Universe.new(100) # which creates 100*100 board with all dead cells
```

To seed the board we can give list of pairs which makes those cells alive
```
universe = Universe.new(100)
universe.seed([[1,2], [2,2], [3,2]]) # which makes these cells live
```

To start the game
```
universe = Universe.new
universe.seed([[1,2], [2,2], [3,2]]) # which makes these cells live
universe.start_game
# which runs and prints next state of the board in 1 second intervals.

# by default we only print 10 generatations, to print more we can pass it as an argument
universe.start_game(100) # this prints 100 generations in the console.
```

For testing I wrote plain ruby test file under test folder without any external library like minitest or Rspec for simplicity.




