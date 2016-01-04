class Life.Game
  board: null


  constructor: (board, @neighbours, @rules) ->
    @switch_board(board)


  step: () ->
    new_board = new Life.Board(@board.size, @rules.initial_state)

    for x in [0...@board.size[0]]
      for y in [0...@board.size[1]]
        position = [x, y]
        new_state = @rules.step(@board.at(position), @neighbours.of(position))
        new_board.set(position, new_state)

    @switch_board(new_board)


  switch_board: (new_board) ->
    @board = new_board
    @neighbours.on(@board)


class Life.Game.Conway extends Life.Game
  constructor: (size, neighbourhood = Life.Neighbourhood.Star) ->
    rules = new Life.Rules.Conway()
    board = new Life.Board(size, rules.initial_state)
    neighbours = new neighbourhood()

    super(board, neighbours, rules)
