class Life.Game
  board: null
  generation: -1


  constructor: (board, @neighbours, @rules) ->
    @switch_board(board)


  step: () ->
    new_board = new Life.Board.Folded(@board.size, @rules.initial_state)

    for x in [0...@board.size[0]]
      for y in [0...@board.size[1]]
        position = [x, y]
        new_state = @rules.step(@board.at(position), @neighbours.of(position))
        new_board.set(position, new_state)

    @generation++
    @switch_board(new_board)


  switch_board: (new_board) ->
    @board = new_board
    @neighbours.on(@board)


  @build: (size, neighbourhood, rules_class) ->
    rules = new rules_class()
    board = new Life.Board.Folded(size, rules.initial_state)
    neighbours = new neighbourhood()

    return new Life.Game(board, neighbours, rules)


